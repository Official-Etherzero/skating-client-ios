//
//  YYNodeOutPutController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeOutPutController.h"
#import "YYViewHeader.h"
#import "MySelfNodeDetailHeaderView.h"
#import "YYNodeViewModel.h"
#import "YYUserDefaluts.h"
#import "NodeRewardModel.h"
#import "YYInterfaceMacro.h"
#import "NodeRewardCell.h"

@interface YYNodeOutPutController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) NodeDetailModel *model;
@property (nonatomic, strong) MySelfNodeDetailHeaderView *headerView;
@property (nonatomic, strong) YYNodeViewModel *viewModel;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NodeRewardModel *rewardModel;
@property (nonatomic, strong) YYLabel         *titleView;

@end

@implementation YYNodeOutPutController

- (instancetype)initNodeDetailWithModel:(NodeDetailModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"产出明细");
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    [self getDatas];
}

- (void)initSubViews {
    self.headerView = [[MySelfNodeDetailHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_26);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.size.mas_offset(CGSizeMake(YYSIZE_349, YYSIZE_108));
    }];
    self.headerView.model = self.model;
    
    self.titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_1a1a1a text:YYStringWithKey(@"收益记录")];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_20);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_25);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_40;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NodeRewardCell class]
           forCellReuseIdentifier:[NodeRewardCell identifier]];
}

- (void)getDatas {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetNodeRewardListWithPageSize:1 currentPage:200 nodeId:self.model.NodeID token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NodeRewardModel class]]) {
            WDStrongify(self);
            self.rewardModel = responseObject;
            [self.tableView reloadData];
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rewardModel.UserNodeList.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeRewardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[NodeRewardCell identifier] forIndexPath:indexPath];
    cell.model = self.rewardModel.UserNodeList[indexPath.row];
    return cell;
}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

@end
