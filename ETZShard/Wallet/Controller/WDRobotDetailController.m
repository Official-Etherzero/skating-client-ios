//
//  WDRobotDetailController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotDetailController.h"
#import "RobotBottomView.h"
#import "YYMillViewModel.h"
#import "RobotDetailTopView.h"
#import "YYViewHeader.h"
#import "RobotIncomeCell.h"
#import "WalletDataManager.h"
#import "RobotBenefitsModel.h"
#import "YYToastView.h"
#import "YYInterfaceMacro.h"

@interface WDRobotDetailController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) RunningRobotModel  *model;
@property (nonatomic, strong) YYMillViewModel    *viewModel;
@property (nonatomic, strong) RobotDetailTopView *topView;
@property (nonatomic, strong) RobotBottomView    *bottomView;
@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) AccountModel       *accountModel;
@property (nonatomic, strong) RobotBenefitsModel *benefitsModel;
@property (nonatomic, strong) NSArray<MinerIncomeModel *> *models;

@end

@implementation WDRobotDetailController

- (instancetype)initRobotDetailWithModel:(RunningRobotModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"Robot");
    self.accountModel = [WalletDataManager accountModel];
    [self initSubViews];
    [self initViewModel];
}

- (void)initSubViews {
    self.topView = [[RobotDetailTopView alloc] init];
    self.topView.model = self.model;
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_10);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_10);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_150));
    }];
    self.topView.layer.shadowColor = [UIColor colorWithRed:210/255.0 green:212/255.0 blue:217/255.0 alpha:0.3].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0,5);
    self.topView.layer.shadowOpacity = 1;
    self.topView.layer.shadowRadius = 10;
    self.topView.layer.cornerRadius = 5;
    
    self.bottomView = [[RobotBottomView alloc] initWithTitle:YYStringWithKey(@"机器人列表")];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_40;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_52);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RobotIncomeCell class]
           forCellReuseIdentifier:[RobotIncomeCell identifier]];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelListOfRobotBenefitsPageSize:1 currentPage:100 miniID:self.model.MiniID userId:self.accountModel.userId success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[RobotBenefitsModel class]]) {
            WDStrongify(self);
            self.benefitsModel = responseObject;
            self.topView.income = self.benefitsModel.TotalEarning;
            [self.tableView reloadData];
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.benefitsModel.MiningEarningList.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RobotIncomeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RobotIncomeCell identifier] forIndexPath:indexPath];
    cell.model = self.benefitsModel.MiningEarningList[indexPath.row];
    return cell;
}

#pragma mark - lazy

- (YYMillViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYMillViewModel alloc] init];
    }
    return _viewModel;
}


@end
