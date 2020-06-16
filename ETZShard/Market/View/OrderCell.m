//
//  OrderCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "OrderCell.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"

@interface OrderCell ()

@property (nonatomic, strong) YYLabel  *addressView;
@property (nonatomic, strong) YYLabel  *numberView;
@property (nonatomic, strong) YYLabel  *unitPriceView; 
@property (nonatomic, strong) YYLabel  *totalPriceView;
@property (nonatomic, strong) YYButton *confrimView;

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 1));
        }];
        
        self.addressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a text:@""];
        self.addressView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.addressView];
        [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_22);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        }];
        
        YYLabel *numTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"数量")];
        numTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:numTitleView];
        [numTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addressView.mas_left);
            make.top.mas_equalTo(self.addressView.mas_bottom).offset(YYSIZE_15);
        }];
        
        self.numberView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.numberView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.numberView];
        [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(numTitleView.mas_right).offset(YYSIZE_10);
            make.top.mas_equalTo(numTitleView.mas_top);
        }];
        
        YYLabel *unitTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"单价")];
        unitTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:unitTitleView];
        [unitTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addressView.mas_left);
            make.top.mas_equalTo(numTitleView.mas_bottom).offset(YYSIZE_10);
        }];
        
        self.unitPriceView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@""];
        self.unitPriceView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.unitPriceView];
        [self.unitPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(unitTitleView.mas_right).offset(YYSIZE_10);
            make.top.mas_equalTo(unitTitleView.mas_top);
        }];
        
        YYLabel *totalTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"总价")];
        totalTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:totalTitleView];
        [totalTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addressView.mas_left);
            make.top.mas_equalTo(unitTitleView.mas_bottom).offset(YYSIZE_10);
        }];
        
        self.totalPriceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_ff5959 text:@""];
        self.totalPriceView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.totalPriceView];
        [self.totalPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(totalTitleView.mas_right).offset(YYSIZE_10);
            make.centerY.mas_equalTo(totalTitleView.mas_centerY);
        }];
        
        self.confrimView = [[YYButton alloc] initWithFont:FONT_DESIGN_28 borderWidth:0 borderColoer:COLOR_ff5959.CGColor masksToBounds:YES title:YYStringWithKey(@"卖出") titleColor:COLOR_ffffff backgroundColor:COLOR_ff5959 cornerRadius:2.0f];
        self.confrimView.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.confrimView];
        [self.confrimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_25);
            make.size.mas_offset(CGSizeMake(YYSIZE_85, YYSIZE_28));
        }];
        WDWeakify(self);
        [self.confrimView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.confirmBlock) {
                self.confirmBlock(self.model);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setModel:(OrderModel *)model {
    _model = model;
    NSString *typeStr;
    if (model.OrderID.length > 1) {
        typeStr = [model.OrderID substringWithRange:NSMakeRange(0, 1)];
    }
    UIColor *showColor = [typeStr isEqualToString:@"M"] ? COLOR_2ad194 : COLOR_ff5959;
    NSString *title = [typeStr isEqualToString:@"M"] ? YYStringWithKey(@"购买") : YYStringWithKey(@"卖出");
    self.totalPriceView.textColor = showColor;
    self.confrimView.backgroundColor = showColor;
    [self.confrimView setBackgroundImage:[UIImage yy_imageWithColor:showColor] forState:UIControlStateNormal];
    [self.confrimView setTitle:title forState:UIControlStateNormal];
    self.addressView.text = model.UBIWallet;
    self.numberView.text = [NSString stringWithFormat:@"%@ UBI",[[NSString stringWithFormat:@"%f",model.UBI] yy_holdDecimalPlaceToIndex:4]];
    self.unitPriceView.text = [NSString stringWithFormat:@"%@ USDT",[[NSString stringWithFormat:@"%f",model.Price] yy_holdDecimalPlaceToIndex:4]];
    float total = model.Price * model.UBI;
    NSString *totalStr = [NSString stringWithFormat:@"%f",total];
    self.totalPriceView.text = [NSString stringWithFormat:@"%@ USDT",[totalStr yy_holdDecimalPlaceToIndex:4]];
}

+ (NSString *)identifier {
    return @"OrderCell";
}

@end
