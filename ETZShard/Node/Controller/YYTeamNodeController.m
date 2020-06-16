//
//  YYTeamNodeController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTeamNodeController.h"
#import "YYViewHeader.h"
#import "YYTeamNodeHeaderView.h"
#import "YYNodeViewModel.h"
#import "TeamNodeCell.h"
#import "TeamNodeModel.h"
#import "YYUserDefaluts.h"
#import "YYInterfaceMacro.h"
#import "YYTeamRewardDetailController.h"

@interface YYTeamNodeController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) YYTeamNodeHeaderView *headerView;
@property (nonatomic, strong) YYNodeViewModel      *viewModel;
@property (nonatomic, strong) UITableView          *tableView;
@property (nonatomic, strong) TeamNodeModel        *model;

@end

@implementation YYTeamNodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"团队节点");
    [self initSubViews];
    [self getTeamNodes];
}

- (void)initSubViews {
    self.headerView = [[YYTeamNodeHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_26);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_26);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_357, YYSIZE_176));
    }];
    WDWeakify(self);
    self.headerView.rewardDetailBlock = ^{
        WDStrongify(self);
        [self.navigationController pushViewController:[YYTeamRewardDetailController new] animated:YES];
    };
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_108;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_30);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TeamNodeCell class]
           forCellReuseIdentifier:[TeamNodeCell identifier]];
}

- (void)getTeamNodes {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetTeamNodeListWithPageSize:1 currentPage:100 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[TeamNodeModel class]]) {
            WDStrongify(self);
            self.model = responseObject;
            self.headerView.model = responseObject;
            [self.tableView reloadData];
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.UserNodeList.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamNodeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[TeamNodeCell identifier] forIndexPath:indexPath];
    cell.model = self.model.UserNodeList[indexPath.row];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YYTeamRewardDetailController *vc = [YYTeamRewardDetailController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

- (TeamNodeModel *)model {
    if (!_model) {
        _model = [TeamNodeModel new];
    }
    return _model;
}


@end
