//
//  YYAddNodeController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYAddNodeController.h"
#import "YYViewHeader.h"
#import "AddNodeHeaderView.h"
#import "YYNodeViewModel.h"
#import "NodeCell.h"
#import "NodeModel.h"
#import "YYInterfaceMacro.h"
#import "YYNodeDetailController.h"
#import "RequestModel.h"
#import "YYUserInfoViewModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYUserDefaluts.h"

@interface YYAddNodeController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) AddNodeHeaderView *headerView;
@property (nonatomic, strong) YYNodeViewModel   *viewModel;
@property (nonatomic, strong) YYButton          *bannerView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray<NodeModel *> *models;
@property (nonatomic, strong) YYUserInfoViewModel *infoViewModel;

@end

@implementation YYAddNodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"增加节点");
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    [self getDatas];
}

- (void)initSubViews {
    self.headerView = [[AddNodeHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_26);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_26);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_175));
    }];
    WDWeakify(self);
    self.headerView.addNodeBlock = ^(NodeModel * _Nonnull model) {
        WDStrongify(self);
        YYNodeDetailController *vc = [[YYNodeDetailController alloc] initNodeModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.bannerView = [[YYButton alloc] init];
    [self.bannerView setBackgroundImage:[UIImage imageNamed:@"banner"] forState:UIControlStateNormal];
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.bannerView bk_addEventHandler:^(id  _Nonnull sender) {
        // 签到
        WDStrongify(self);
        [self.infoViewModel yy_viewModelSignInWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[RequestModel class]]) {
                RequestModel *model = responseObject;
                if (model.code == 0) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"签到成功") attachedView:[UIApplication sharedApplication].keyWindow];
                } else {
                    [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
                }
            }
        } failure:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_44 textColor:COLOR_1a1a1a text:YYStringWithKey(@"稳健收益")];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(YYSIZE_15);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_25);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_108;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NodeCell class]
           forCellReuseIdentifier:[NodeCell identifier]];
}

- (void)getDatas {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetNodeListSuccess:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            [self.models addObjectsFromArray:responseObject];
            self.headerView.model = self.models.firstObject;
            [self.models removeObjectAtIndex:0];
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
    NodeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[NodeCell identifier] forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeModel *model = self.models[indexPath.row];
    YYNodeDetailController *vc = [[YYNodeDetailController alloc] initNodeModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)infoViewModel {
    if (!_infoViewModel) {
        _infoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _infoViewModel;
}

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableArray<NodeModel *> *)models {
    if (!_models) {
           _models = @[].mutableCopy;
       }
       return _models;
}

@end
