//
//  WalletHeaderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WalletHeaderView.h"
#import "YYViewHeader.h"
#import "ImageCenterButton.h"

#import "YYToastView.h"
#import "NSString+Ext.h"
#import "YYExchangeRateModel.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>

@interface WalletHeaderView ()

@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UILabel     *totalAssetsLabel;
@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;
@property (nonatomic, strong) YYButton    *walletView;
@property (nonatomic, strong) YYButton    *rightView;

@end

@implementation WalletHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *bottomView = [[UIImageView alloc] init];
    bottomView.image = [UIImage imageNamed:@"card"];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    // totalAssets
    UILabel *titleView = [UILabel new];
    [self addSubview:titleView];
    titleView.text = YYStringWithKey(@"我的 ETZ 钱包");
    titleView.textColor = COLOR_ccfff0;
    titleView.font = FONT_DESIGN_24;
    titleView.textAlignment = NSTextAlignmentLeft;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_52);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    UILabel *totalAssetsLabel = [UILabel new];
    totalAssetsLabel.textColor = COLOR_ffffff;
    totalAssetsLabel.font = FONT_DESIGN_72;
    totalAssetsLabel.text = @"0";
    totalAssetsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:totalAssetsLabel];
    [totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(YYSIZE_10);
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_20);
    }];
    self.totalAssetsLabel = totalAssetsLabel;
    
    UILabel *symbolLabel = [UILabel new];
    symbolLabel.textColor = titleView.textColor = COLOR_ccfff0;
    symbolLabel.font = FONT_DESIGN_30;
    symbolLabel.text = @"≈";
    symbolLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:symbolLabel];
    [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(totalAssetsLabel.mas_centerY);
        make.right.mas_equalTo(totalAssetsLabel.mas_left).offset(-YYSIZE_10);
    }];
    
    self.addressLabel = [UILabel new];
    self.addressLabel.textColor = COLOR_ffffff;
    self.addressLabel.font = FONT_DESIGN_22;
    self.addressLabel.text = @"0xdddf8dsfsdf9sdfsdfs9sdssdfsdf";
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-YYSIZE_20);
        make.top.mas_equalTo(symbolLabel.mas_bottom).offset(YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_182, YYSIZE_11));
    }];
    
    YYButton *copyBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:copyBtn];
    copyBtn.stretchLength = 5.0f;
    [copyBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressLabel.mas_right).offset(YYSIZE_09);
        make.centerY.mas_equalTo(self.addressLabel.mas_centerY);
    }];
    [copyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightView = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.rightView setBackgroundImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
    [self addSubview:self.rightView];
    self.rightView.stretchLength = 10.0f;
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_21);
    }];
    WDWeakify(self);
    [self.rightView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.enterWalletBlock) {
            self.enterWalletBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];;
}

- (void)copyClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.address;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:[UIApplication sharedApplication].keyWindow];
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    self.addressLabel.text = model.address;
    if (model.balance && ![model.balance isEqualToString:@"0"]) {
        if (self.rateModels.count > 0) {
            NSString *price = [YYExchangeRateModel yy_getPriceByModels:self.rateModels balance:self.model.balance];
            self.totalAssetsLabel.text = [price yy_holdDecimalPlaceToIndex:2];
        }
    }
}



@end
