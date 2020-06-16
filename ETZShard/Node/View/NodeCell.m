//
//  NodeCell.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "NodeCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "NSString+Ext.h"
#import "YYEnum.h"

@interface NodeCell ()

@property (nonatomic, strong) YYLabel     *nodeNameView;
@property (nonatomic, strong) YYLabel     *earningView;
@property (nonatomic, strong) YYLabel     *cycleView;
@property (nonatomic, strong) YYLabel     *priceView;
@property (nonatomic, strong) UIImageView *bottomView;

@end

@implementation NodeCell

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
        
        self.earningView = [[YYLabel alloc] initWithFont:FONT_DESIGN_40 textColor:COLOR_ffe993 text:@"120%"];
        [bottomView addSubview:self.earningView];
        [self.earningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nodeNameView.mas_left);
            make.top.mas_equalTo(self.nodeNameView.mas_bottom).offset(YYSIZE_12);
        }];
        
        YYLabel *earningTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_ffe993 text:YYStringWithKey(@"月收益率")];
        [bottomView addSubview:earningTitleView];
        [earningTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nodeNameView.mas_left);
            make.top.mas_equalTo(self.earningView.mas_bottom).offset(YYSIZE_03);
        }];
        
        self.cycleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:YYStringWithKey(@"1080天")];
        self.cycleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:self.cycleView];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.earningView.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"周期")];
        cycleTitleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:cycleTitleView];
        [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(earningTitleView.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"1000 ETZ"];
        self.priceView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_15);
            make.centerY.mas_equalTo(self.cycleView.mas_centerY);
        }];
        
        YYLabel *priceTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"售价")];
        priceTitleView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:priceTitleView];
        [priceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.priceView.mas_right);
            make.centerY.mas_equalTo(earningTitleView.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(NodeModel *)model {
    _model = model;
    self.nodeNameView.text = model.Name;
    self.earningView.text = [NSString stringWithFormat:@"%ld%@",(long)model.Earnings,@"%"];
    self.cycleView.text = [NSString stringWithFormat:@"%@ 天",model.Period];
    self.priceView.text = [NSString stringWithFormat:@"%@ ETZ",model.Input];
    self.bottomView.image = [UIImage imageNamed:yyGetNodeTypeString(model.MType)];
}

+ (NSString *)identifier {
    return @"NodeCell";
}

@end
