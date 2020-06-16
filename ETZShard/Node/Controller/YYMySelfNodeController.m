//
//  YYMySelfNodeController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYMySelfNodeController.h"
#import "YYViewHeader.h"
#import "MySelfHeaderView.h"
#import "YYNodeViewModel.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "MySelfNodeModel.h"
#import "YYAddNodeController.h"
#import "YYUserDefaluts.h"
#import "MySelfNodeCell.h"
#import "YYNodeOutPutController.h"

@interface YYMySelfNodeController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) YYNodeViewModel   *viewModel;
@property (nonatomic, strong) MySelfHeaderView  *headerView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) YYButton          *addView;
@property (nonatomic, strong) MySelfNodeModel   *model;

@end

@implementation YYMySelfNodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"个人节点");
    [self initSubViews];
    [self initViewModel];
}

- (void)initSubViews {
    self.headerView = [[MySelfHeaderView alloc] init];
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
    
    self.addView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"+ 增加节点") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    [self.view addSubview:self.addView];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_15);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(YYSIZE_15);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(331, 47));
    }];
    WDWeakify(self);
    [self.addView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.navigationController pushViewController:[YYAddNodeController new] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_108;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_12);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MySelfNodeCell class]
           forCellReuseIdentifier:[MySelfNodeCell identifier]];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelMyNodeListWithPageSize:1 currentPage:100 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[MySelfNodeModel class]]) {
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
    MySelfNodeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[MySelfNodeCell identifier] forIndexPath:indexPath];
    cell.model = self.model.UserNodeList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeDetailModel *model = self.model.UserNodeList[indexPath.row];
    YYNodeOutPutController *vc = [[YYNodeOutPutController alloc] initNodeDetailWithModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

- (MySelfNodeModel *)model {
    if (!_model) {
        _model = [[MySelfNodeModel alloc] init];
    }
    return _model;
}

@end
