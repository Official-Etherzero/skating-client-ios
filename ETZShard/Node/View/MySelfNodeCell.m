//
//  MySelfNodeCell.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "MySelfNodeCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "NSString+Ext.h"
#import "YYEnum.h"

@interface MySelfNodeCell ()

@property (nonatomic, strong) YYLabel     *nodeNameView;
@property (nonatomic, strong) YYLabel     *earningView;
@property (nonatomic, strong) YYLabel     *cycleView;
@property (nonatomic, strong) YYLabel     *priceView;
@property (nonatomic, strong) UIImageView *bottomView;

@property (nonatomic, strong) YYLabel     *totalEarningView;
@property (nonatomic, strong) YYLabel     *lastEarningView;
@property (nonatomic, strong) YYLabel     *dueTimeView;

@end

@implementation MySelfNodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_349, YYSIZE_108));
        }];
        self.bottomView = bottomView;
        
        self.nodeNameView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@"初级节点"];
        [bottomView addSubview:self.nodeNameView];
        [self.nodeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_15);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        }];
        
        self.earningView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff_A06 text:@"累计收益"];
        [bottomView addSubview:self.earningView];
        [self.earningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nodeNameView.mas_left);
            make.top.mas_equalTo(self.nodeNameView.mas_bottom).offset(YYSIZE_12);
        }];
        
        self.totalEarningView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_ffffff text:YYStringWithKey(@"10000")];
        [bottomView addSubview:self.totalEarningView];
        [self.totalEarningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.earningView.mas_left);
            make.top.mas_equalTo(self.earningView.mas_bottom).offset(YYSIZE_03);
        }];
        
        self.cycleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"昨日收益")];
        self.cycleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:self.cycleView];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.earningView.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.lastEarningView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_ffffff text:@"+1000"];
        self.lastEarningView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:self.lastEarningView];
        [self.lastEarningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.totalEarningView.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"距离到期")];
        self.priceView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_15);
            make.centerY.mas_equalTo(self.cycleView.mas_centerY);
        }];
        
        self.dueTimeView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_ffffff text:YYStringWithKey(@"1000天")];
        self.dueTimeView .textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:self.dueTimeView ];
        [self.dueTimeView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.priceView.mas_centerX);
            make.centerY.mas_equalTo(self.totalEarningView.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(NodeDetailModel *)model {
    _model = model;
    self.nodeNameView.text = yyGetNodeMiniIdString(model.MiniID);
    self.totalEarningView.text = [model.Reward yy_holdDecimalPlaceToIndex:4];
    self.lastEarningView.text = [[NSString stringWithFormat:@"+%@",model.RewardYesterday] yy_holdDecimalPlaceToIndex:4];
    self.dueTimeView.text = [NSString stringWithFormat:@"%ld天",(long)model.RestOfDay];
    self.bottomView.image = [UIImage imageNamed:yyGetNodeTypeString(model.MiniID)];
}

+ (NSString *)identifier {
    return @"MySelfNodeCell";
}



@end
