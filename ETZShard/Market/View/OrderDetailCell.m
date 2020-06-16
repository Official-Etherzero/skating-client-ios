//
//  OrderDetailCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "OrderDetailCell.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"

@interface OrderDetailCell ()

@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) YYLabel     *codeView;
@property (nonatomic, strong) YYLabel     *timeView;
@property (nonatomic, strong) YYLabel     *statusView;
@property (nonatomic, strong) YYLabel     *priceView;
@property (nonatomic, strong) YYLabel     *dataView;
@property (nonatomic, strong) YYLabel     *totalView;

@end

@implementation OrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = COLOR_edf0f5;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
        }];
        
        self.leftView = [[UIImageView alloc] init];
        self.leftView.image = [UIImage imageNamed:@""];
        [self addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_20);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_15));
        }];
        
        self.codeView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_1a1a1a text:@""];
        [self addSubview:self.codeView];
        self.codeView.textAlignment = NSTextAlignmentCenter;
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftView.mas_right).offset(YYSIZE_06);
            make.centerY.mas_equalTo(self.leftView.mas_centerY);
        }];
        
        self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A05 text:@""];
        [self addSubview:self.timeView];
        self.timeView.textAlignment = NSTextAlignmentCenter;
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.codeView.mas_right).offset(YYSIZE_06);
            make.centerY.mas_equalTo(self.leftView.mas_centerY);
        }];
        
        self.statusView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_24 textColor:COLOR_1a1a1a text:@""];
        self.statusView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.statusView];
        [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(self.leftView.mas_centerY);
        }];
        
        YYLabel *priceTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"单价")];
        priceTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceTitleView];
        [priceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(self.leftView.mas_bottom).offset(YYSIZE_16);
        }];
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.priceView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(priceTitleView.mas_left);
            make.top.mas_equalTo(priceTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *dataTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"数量")];
        dataTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:dataTitleView];
        [dataTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_160);
            make.centerY.mas_equalTo(priceTitleView.mas_centerY);
        }];
        
        self.dataView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.dataView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.dataView];
        [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dataTitleView.mas_left);
            make.top.mas_equalTo(dataTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *totalTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"总金额")];
        totalTitleView.textAlignment = NSTextAlignmentRight;
        [self addSubview:totalTitleView];
        [totalTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(priceTitleView.mas_centerY);
        }];
        
        self.totalView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.totalView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.totalView];
        [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(totalTitleView.mas_right);
            make.top.mas_equalTo(totalTitleView.mas_bottom).offset(YYSIZE_06);
        }];
    }
    return self;
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    NSString *icon = model.direction == 1 ? @"tab_sell" : @"tab_buy";
    self.leftView.image = [UIImage imageNamed:icon];
    self.codeView.text = @"UBI";
    self.timeView.text = model.WriteTime;
    if (model.Status == 4) {
        self.statusView.text = YYStringWithKey(@"已完成");
    } else if (model.Status == 6) {
        self.statusView.text = YYStringWithKey(@"已取消");
    } else {
        self.statusView.text = YYStringWithKey(@"进行中");
    }
    self.priceView.text = [[NSString stringWithFormat:@"%f",model.Price] yy_holdDecimalPlaceToIndex:4];
    self.dataView.text = [[NSString stringWithFormat:@"%f",model.UBI] yy_holdDecimalPlaceToIndex:4];
    float total = model.Price * model.UBI;
    NSString *totalStr = [NSString stringWithFormat:@"%f",total];
    self.totalView.text = [NSString stringWithFormat:@"%@ USDT",[totalStr yy_holdDecimalPlaceToIndex:4]];
}

+ (NSString *)identifier {
    return @"OrderDetailCell";
}


@end
