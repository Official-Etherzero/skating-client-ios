//
//  AddNodeHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "AddNodeHeaderView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "UIView+Ext.h"
#import "YYEnum.h"

@interface AddNodeHeaderView ()

@property (nonatomic, strong) YYLabel *userNameView;
@property (nonatomic, strong) YYLabel *rewardView;
@property (nonatomic, strong) YYLabel *cycleView;
@property (nonatomic, strong) YYLabel *contentView;

@end

@implementation AddNodeHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_3d5afe;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [bottomView yy_setGradientColors:@[(__bridge id)COLOR_4871ff.CGColor,(__bridge id)COLOR_4754ff.CGColor]];
    bottomView.layer.cornerRadius = 5.0f;
    bottomView.clipsToBounds = YES;
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_ffffff text:YYStringWithKey(@"体验节点")];
    [bottomView addSubview:titleView];
    titleView.textAlignment = NSTextAlignmentCenter;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_18);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.userNameView = titleView;
    
    YYLabel *earningsView = [[YYLabel alloc] initWithFont:FONT_DESIGN_44 textColor:COLOR_ffe993 text:@"12%"];
    earningsView.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:earningsView];
    [earningsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_50);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_60);
    }];
    self.rewardView = earningsView;
    
    YYLabel *earningsTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"月收益率")];
    [bottomView addSubview:earningsTitleView];
    [earningsTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(earningsView.mas_centerX);
        make.top.mas_equalTo(earningsView.mas_bottom).offset(YYSIZE_05);
    }];
    
    YYLabel *cycleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_44 textColor:COLOR_ffffff text:@"1080天"];
    cycleView.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:cycleView];
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(earningsView.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
    }];
    self.cycleView = cycleView;
    
    YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"周期")];
    [bottomView addSubview:cycleTitleView];
    [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(cycleView.mas_centerX);
        make.centerY.mas_equalTo(earningsTitleView.mas_centerY);
    }];
    
    UIView *lastView = [[UIView alloc] init];
    lastView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    lastView.layer.cornerRadius = 3;
    [self addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_118);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_37));
    }];
    
    YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_32 textColor:COLOR_3573ff text:YYStringWithKey(@"1000 ETZ 马上试试")];
    contentView.textAlignment = NSTextAlignmentCenter;
    [lastView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(lastView.mas_centerX);
        make.centerY.mas_equalTo(lastView.mas_centerY);
    }];
    self.contentView = contentView;
    
    UITapGestureRecognizer *focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(tapBuyClick)];
    [self addGestureRecognizer:focusTapGesture];
}

- (void)tapBuyClick {
    if (self.addNodeBlock) {
        self.addNodeBlock(self.model);
    }
}

- (void)setModel:(NodeModel *)model {
    _model = model;
    self.userNameView.text = model.Name;
    self.rewardView.text = [NSString stringWithFormat:@"%ld%@",(long)model.Earnings,@"%"];
    self.cycleView.text = [NSString stringWithFormat:@"%@ 天",model.Period];
    self.contentView.text = [NSString stringWithFormat:@"%@ETZ 马上试试",model.Input];
}


@end
