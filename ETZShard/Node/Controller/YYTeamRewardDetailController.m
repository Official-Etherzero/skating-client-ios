//
//  YYTeamRewardDetailController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTeamRewardDetailController.h"
#import "YYViewHeader.h"
#import "YYNodeViewModel.h"
#import "YYInterfaceMacro.h"
#import "YYUserDefaluts.h"
#import "NodeRewardModel.h"
#import "NodeRewardCell.h"

@interface YYTeamRewardDetailController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) YYNodeViewModel *viewModel;
@property (nonatomic,   copy) NSArray<RewardModel *> *models;

@end

@implementation YYTeamRewardDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"奖励明细");
    self.view.backgroundColor = COLOR_ffffff;
    [self initViewModel];
    [self initSubViews];
}

- (void)initSubViews {
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_40;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NodeRewardCell class]
           forCellReuseIdentifier:[NodeRewardCell identifier]];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetTeamRewardListWithPageSize:1 currentPage:200 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.models = responseObject;
            [self.tableView reloadData];
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeRewardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[NodeRewardCell identifier] forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

- (NSArray<RewardModel *> *)models {
    if (!_models) {
        _models = @[].copy;
    }
    return _models;
}

@end
