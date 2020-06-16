//
//  RobotDetailTopView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotDetailTopView.h"
#import "YYViewHeader.h"
#import "YYDateModel.h"
#import "NSString+Ext.h"
#import "YYPercentView.h"

@interface RobotDetailTopView ()

@property (nonatomic, strong) YYLabel *nameView;
@property (nonatomic, strong) YYLabel *startView;
@property (nonatomic, strong) YYLabel *endView;
@property (nonatomic, strong) YYLabel *incomeView;
@property (nonatomic, strong) YYPercentView *percentView;

@end

@implementation RobotDetailTopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.nameView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_1a1a1a text:@""];
    self.nameView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_16);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_12);
        make.height.mas_offset(YYSIZE_20);
    }];
    
    YYLabel *startTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"启动日期")];
    [self addSubview:startTitleView];
    startTitleView.textAlignment = NSTextAlignmentLeft;
    [startTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView.mas_left);
        make.top.mas_equalTo(self.nameView.mas_bottom).offset(YYSIZE_18);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.startView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:@""];
    [self addSubview:self.startView];
    self.startView.textAlignment = NSTextAlignmentLeft;
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startTitleView.mas_right).offset(YYSIZE_15);
        make.top.mas_equalTo(startTitleView.mas_top);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    YYLabel *endTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"到期日期")];
    endTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:endTitleView];
    [endTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView.mas_left);
        make.top.mas_equalTo(startTitleView.mas_bottom).offset(YYSIZE_13);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.endView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:@""];
    [self addSubview:self.endView];
    self.endView.textAlignment = NSTextAlignmentLeft;
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startView.mas_left);
        make.top.mas_equalTo(endTitleView.mas_top);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    YYLabel *incomeTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_24 textColor:COLOR_1a1a1a text:YYStringWithKey(@"累计收益")];
    incomeTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:incomeTitleView];
    [incomeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView.mas_left);
        make.top.mas_equalTo(endTitleView.mas_bottom).offset(YYSIZE_22);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.incomeView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ff5959 text:@""];
    [self addSubview:self.incomeView];
    self.incomeView.textAlignment = NSTextAlignmentRight;
    [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.centerY.mas_equalTo(incomeTitleView.mas_centerY);
        make.height.mas_offset(YYSIZE_17);
    }];
    
    self.percentView = [[YYPercentView alloc] init];
    [self addSubview:self.percentView];
    [self.percentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_27);
        make.size.mas_offset(CGSizeMake(YYSIZE_62, YYSIZE_62));
    }];
}

- (void)setModel:(RunningRobotModel *)model {
    _model = model;
    self.nameView.text = model.Name;
    self.startView.text = [YYDateModel yy_getCustomTimeWithTimeStamp:model.StartTime];
    self.endView.text = [YYDateModel yy_getCustomTimeWithTimeStamp:model.ExpireTime];
    self.percentView.percent = model.RateOfProgress;
}

- (void)setIncome:(double)income {
    _income = income;
    self.incomeView.text = [[NSString stringWithFormat:@"%f",income] yy_holdDecimalPlaceToIndex:4];
}


@end
