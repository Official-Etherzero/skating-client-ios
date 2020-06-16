//
//  YYTransferDetailController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTransferDetailController.h"
#import "YYViewHeader.h"
#import "RecordDetailCell.h"
#import "YYNodeViewModel.h"
#import "YYUserDefaluts.h"
#import "YYInterfaceMacro.h"

@interface YYTransferDetailController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) YYNodeViewModel *viewModel;
@property (nonatomic,   copy) NSArray<DetailModel *> *models;

@end

@implementation YYTransferDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"充提记录");
    self.view.backgroundColor = COLOR_ffffff;
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initViewModel];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_60;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RecordDetailCell class]
           forCellReuseIdentifier:[RecordDetailCell identifier]];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetRewardDetailWithPageSize:1 currentPage:500 type:0 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.models = responseObject;
            [self.tableView reloadData];
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RecordDetailCell identifier] forIndexPath:indexPath];
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

- (NSArray<DetailModel *> *)models {
    if (!_models) {
        _models = @[].copy;
    }
    return _models;
}

@end
