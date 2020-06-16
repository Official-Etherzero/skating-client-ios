//
//  MySelfHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "MySelfHeaderView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface MySelfHeaderView ()

@property (nonatomic, strong) YYLabel *totalRewardView;
@property (nonatomic, strong) YYLabel *nodesView;
@property (nonatomic, strong) YYLabel *lastRewardView;

@end

@implementation MySelfHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *bottomView = [[UIImageView alloc] init];
    bottomView.image = [UIImage imageNamed:@"gerenjiedian_bg"];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"总奖励 (ETZ)")];
    [self addSubview:titleView];
    titleView.textAlignment = NSTextAlignmentCenter;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_18);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    self.totalRewardView = [[YYLabel alloc] initWithFont:FONT_DESIGN_70 textColor:COLOR_ffffff text:@"20000"];
    self.totalRewardView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.totalRewardView];
    [self.totalRewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_40);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYLabel *nodesTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"节点总数(个)")];
    [self addSubview:nodesTitleView];
    [nodesTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_45);
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_90);
    }];
    
    self.nodesView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"1000"];
    [self addSubview:self.nodesView];
    [self.nodesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nodesTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(nodesTitleView.mas_centerX);
    }];
    
    YYLabel *lastRewardTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"昨日产出(ETZ)")];
    [self addSubview:lastRewardTitleView];
    [lastRewardTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_45);
        make.top.mas_equalTo(nodesTitleView.mas_top);
    }];
    
    self.lastRewardView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"10000"];
    [self addSubview:self.lastRewardView];
    [self.lastRewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastRewardTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(lastRewardTitleView.mas_centerX);
    }];
}

- (void)setModel:(MySelfNodeModel *)model {
    self.totalRewardView.text = model.TotalReward;
    self.nodesView.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.UserNodeList.count];
    self.lastRewardView.text = model.TotalRewardYesterday;
}

@end
