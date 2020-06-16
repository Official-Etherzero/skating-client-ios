//
//  NodeAssetsView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "NodeAssetsView.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "RateModel.h"
#import "YYExchangeRateModel.h"

@interface NodeAssetsView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleView;
@property (nonatomic, strong) UILabel     *codeView;
@property (nonatomic, strong) UILabel     *numView;
@property (nonatomic, strong) UILabel     *priceView;
@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;

@end

@implementation NodeAssetsView

- (instancetype)init {
    if (self = [super init]) {
        
        YYLabel *label = [YYLabel new];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT_DESIGN_44;
        label.textColor = COLOR_1a1a1a;
        label.text = YYStringWithKey(@"节点资产");
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_25);
        }];
        
        self.imageView = [UIImageView new];
            self.imageView.image = [UIImage imageNamed:@"node_asset"];
            [self addSubview:self.imageView];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(YYSIZE_23);
                make.top.mas_equalTo(label.mas_bottom).offset(YYSIZE_30);
                make.size.mas_offset(CGSizeMake(YYSIZE_37, YYSIZE_37));
            }];
            
            self.titleView = [self createCustomLabel];
            self.titleView.textColor = COLOR_1a1a1a;
            self.titleView.font = FONT_DESIGN_36;
            self.titleView.textAlignment = NSTextAlignmentLeft;
            self.titleView.text = @"ETZ";
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
                make.top.mas_equalTo(self.imageView.mas_top);
            }];
            
            self.codeView = [self createCustomLabel];
            self.codeView.textColor = COLOR_1a1a1a_A04;
            self.codeView.font = FONT_DESIGN_24;
            self.codeView.text = @"EtherZero";
            self.codeView.textAlignment = NSTextAlignmentLeft;
            [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
        //        make.top.mas_equalTo(self.titleView.mas_bottom).offset(11);
                make.bottom.mas_equalTo(self.imageView.mas_bottom);
            }];
            
            self.numView = [self createCustomLabel];
            self.numView.textColor = COLOR_1a1a1a;
            self.numView.font = FONT_DESIGN_36;
            self.numView.text = @"0";
            self.numView.textAlignment = NSTextAlignmentRight;
            [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
                make.top.mas_equalTo(self.imageView.mas_top);
                make.width.mas_offset(YYSIZE_150);
            }];
            
            self.priceView = [self createCustomLabel];
            self.priceView.textColor = COLOR_1a1a1a_A04;
            self.priceView.font = FONT_DESIGN_24;
            self.priceView.textAlignment = NSTextAlignmentRight;
            [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
        //        make.top.mas_equalTo(self.numView.mas_bottom).offset(8);
                make.bottom.mas_equalTo(self.imageView.mas_bottom);
            }];
            
            UIView *line = [UIView new];
            line.backgroundColor = COLOR_ebecf0;
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.size.mas_offset(CGSizeMake(YYSIZE_331, 1));
            }];
    }
    return self;
}

- (void)setBalance:(NSString *)balance {
    self.numView.text = [balance yy_holdDecimalPlaceToIndex:4];
}

- (UILabel *)createCustomLabel {
    UILabel *l = [UILabel new];
    [self addSubview:l];
    return l;
}


@end
