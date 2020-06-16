//
//  RunningRobotView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RunningRobotView.h"
#import "YYViewHeader.h"
#import "RunningRobotCell.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface RunningRobotView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) YYButton     *addRobotBtn;

@end

@implementation RunningRobotView

- (instancetype)init {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = YYSIZE_110;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_80);
            make.left.right.top.mas_equalTo(self);
        }];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[RunningRobotCell class]
               forCellReuseIdentifier:[RunningRobotCell identifier]];
        
        self.addRobotBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"增加机器人") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
        self.addRobotBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.addRobotBtn];
        [self.addRobotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.tableView.mas_bottom).offset(YYSIZE_10);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
        }];
        WDWeakify(self);
        [self.addRobotBtn bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.addRobotBlock) {
                self.addRobotBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setModels:(NSArray<RunningRobotModel *> *)models {
    _models = models;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RunningRobotCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RunningRobotCell identifier] forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RunningRobotModel *model = self.models[indexPath.row];
    if (self.selectedRobotBlock) {
        self.selectedRobotBlock(model);
    }
}


@end
