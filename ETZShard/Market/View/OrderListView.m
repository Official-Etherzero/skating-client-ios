//
//  OrderListView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "OrderListView.h"
#import "YYViewHeader.h"
#import "OrderDetailCell.h"

@interface OrderListView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation OrderListView

- (instancetype)init {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = YYSIZE_106;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.bottom.top.mas_equalTo(self);
        }];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[OrderDetailCell class]
               forCellReuseIdentifier:[OrderDetailCell identifier]];
    }
    return self;
}

- (void)setModels:(NSArray<OrderModel *> *)models {
    _models = models;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[OrderDetailCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = self.models[indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}


@end
