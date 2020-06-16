//
//  SellListView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SellListView.h"
#import "YYViewHeader.h"
#import "OrderCell.h"
#import "YYInterfaceMacro.h"

@interface SellListView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation SellListView

- (instancetype)init {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = YYSIZE_136;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[OrderCell class]
               forCellReuseIdentifier:[OrderCell identifier]];
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
    OrderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[OrderCell identifier] forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    WDWeakify(self);
    cell.confirmBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        if (self.sellBlock) {
            self.sellBlock(model);
        }
    };
    return cell;
}

@end
