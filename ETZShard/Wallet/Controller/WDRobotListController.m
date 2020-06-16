//
//  WDRobotListController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotListController.h"
#import "YYMillViewModel.h"
#import "RobotTopView.h"
#import "YYViewHeader.h"
#import "YYNavigationView.h"
#import "RobotBottomView.h"
#import "MiningInfosModel.h"
#import "RobotsListCell.h"
#import "YYInterfaceMacro.h"
#import "YYToastView.h"
#import "YYUserDefaluts.h"
#import "WalletDataManager.h"
#import "SettingPasswordView.h"
#import "OrderPasswordView.h"
#import "YYUserInfoViewModel.h"
#import "UserInfoModel.h"

@interface WDRobotListController ()
<YYNavigationViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) RobotTopView              *topView;
@property (nonatomic, strong) YYNavigationView          *navigationView;
@property (nonatomic, strong) YYMillViewModel           *millViewModel;
@property (nonatomic, strong) YYUserInfoViewModel       *userInfoViewModel;
@property (nonatomic, strong) CalculateStatisticalModel *calculateModel;
@property (nonatomic, strong) RobotBottomView           *bottomView;
@property (nonatomic,   copy) NSArray<MiningInfosModel *> *models;
@property (nonatomic,   copy) NSString *address;

@end

@implementation WDRobotListController

- (instancetype)initWithCalculateModel:(CalculateStatisticalModel *)model
                                ubiAddress:(nonnull NSString *)ubiAddress{
    if (self = [super init]) {
        self.calculateModel = model;
        self.address = ubiAddress;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_f5f7fa;
    self.navigationItem.title = YYStringWithKey(@"Robot");
    [self initViewModel];
    [self initSubViews];
    [self getRobotBalance];
}

- (void)initSubViews {
    
    self.navigationView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    [self.navigationView returnButton];
    self.navigationView.delegate = self;
    
    self.topView = [[RobotTopView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_220);
    }];
    self.topView.model = self.calculateModel;
    
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
    self.tableView.rowHeight = YYSIZE_136;
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
    [self.tableView registerClass:[RobotsListCell class]
           forCellReuseIdentifier:[RobotsListCell identifier]];
}

- (void)showPasswordViewWithModel:(MiningInfosModel *)model MinerId:(NSInteger)minerId userId:(NSString *)userId {
    WDWeakify(self);
    [OrderPasswordView showOrderPasswordViewWithModel:model confirmBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.millViewModel yy_viewModelMiningMachinePurchaseWithMinerId:minerId userId:userId password:psd success:^(id  _Nonnull responseObject) {
            [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            // 购买后更新 robot 余额
            [self getRobotBalance];
        } failure:nil];
    } cancelBlock:nil];
}

- (void)initViewModel {
    // 机器人列表
    [self.millViewModel yy_viewModelNumberMinersCanbePurchasedSuccess:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.models = responseObject;
            [self.tableView reloadData];
        }
    } failure:nil];
}

- (void)getRobotBalance {
    [self.userInfoViewModel yy_viewModelWhetherRegisterWithAddress:self.address success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[UserInfoModel class]]) {
            UserInfoModel *model = responseObject;
            self.topView.balance = model.UBIIN;
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RobotsListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RobotsListCell identifier] forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    WDWeakify(self);
    cell.buyMinerBlock = ^(NSInteger minerId) {
        WDStrongify(self);
        NSString *userId = [WalletDataManager accountModel].userId;
        [self showPasswordViewWithModel:self.models[indexPath.row] MinerId:minerId userId:userId];
    };
    return cell;
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (YYMillViewModel *)millViewModel {
    if (!_millViewModel) {
        _millViewModel = [[YYMillViewModel alloc] init];
    }
    return _millViewModel;
}

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

@end
