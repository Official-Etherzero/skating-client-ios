//
//  RobotsListCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotsListCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "NSString+Ext.h"

@interface RobotsListCell ()

@property(nonatomic, strong, readwrite) YYLabel  *titleView;
@property(nonatomic, strong, readwrite) YYLabel  *priceView;
@property(nonatomic, strong, readwrite) YYLabel  *dailyOutput;
@property(nonatomic, strong, readwrite) YYLabel  *cycleView;
@property(nonatomic, strong, readwrite) YYLabel  *remainingView;
@property(nonatomic, strong, readwrite) YYButton *buyBtn;

@end

@implementation RobotsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        separatorView.backgroundColor = COLOR_d4d4d4;
        [self addSubview:separatorView];
        [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_21);
            make.right.mas_equalTo(self).offset(-YYSIZE_21);
            make.bottom.mas_equalTo(self).offset(-0.5);
            make.height.mas_equalTo(0.5);
        }];
        
        self.titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_1a1a1a text:@""];
        self.titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_26);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.height.mas_offset(YYSIZE_15);
        }];
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ff5959 text:@""];
        self.priceView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(self.titleView.mas_centerY);
        }];
        
        YYLabel *daylyTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"每日产出")];
        daylyTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:daylyTitleView];
        [daylyTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        self.dailyOutput = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.dailyOutput.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.dailyOutput];
        [self.dailyOutput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_90);
            make.top.mas_equalTo(daylyTitleView.mas_top);
        }];
        
        YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"周期")];
        cycleTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:cycleTitleView];
        [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(daylyTitleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        self.cycleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.cycleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.cycleView];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_90);
            make.top.mas_equalTo(cycleTitleView.mas_top);
        }];
        
        YYLabel *remainingTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"今日剩余")];
        remainingTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:remainingTitleView];
        [remainingTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(cycleTitleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        self.remainingView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.remainingView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.remainingView];
        [self.remainingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_90);
            make.top.mas_equalTo(remainingTitleView.mas_top);
        }];
        
        self.buyBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"购买") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
        self.buyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.buyBtn];
        [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_17);
            make.size.mas_offset(CGSizeMake(YYSIZE_80, YYSIZE_36));
        }];
        WDWeakify(self);
        [self.buyBtn bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.buyMinerBlock) {
                self.buyMinerBlock(self.model.MiniID);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setModel:(MiningInfosModel *)model {
    _model = model;
    self.titleView.text = yyGetMiningMachineTypeString(model.MiniID);
    self.priceView.text = [NSString stringWithFormat:@"%ld UBI",(long)model.Earnings];
    self.dailyOutput.text = [NSString stringWithFormat:@"%@ UBI",[model.Ret yy_holdDecimalPlaceToIndex:4]];
    self.cycleView.text = [NSString stringWithFormat:@"%ld%@",(long)model.Cycle,YYStringWithKey(@"天")];
    self.remainingView.text = [NSString stringWithFormat:@"%ld%@",(long)model.Limit,YYStringWithKey(@"台")];
}

+ (NSString *)identifier {
    return @"RobotsListCell";
}

@end
