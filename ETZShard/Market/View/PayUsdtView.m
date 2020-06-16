//
//  PayUsdtView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PayUsdtView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"

@interface PayUsdtView ()

@property (nonatomic,   copy) ConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;
@property (nonatomic, strong) YYTextView   *passwordView;

@end

@implementation PayUsdtView

+ (instancetype)showPayUsdtViewWithAddress:(NSString *)address
                                    amount:(NSString *)amount
                              confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                               cancelBlock:(CancelBlock _Nullable)cancelBlock {
    PayUsdtView *view = [[PayUsdtView alloc] initWithAddress:address amount:amount];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)initWithAddress:(NSString *)address amount:(NSString *)amount {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_ffffff;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_210);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_173));
        }];
        
        YYLabel *addressTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"卖家USDT(ETH)收款地址为")];
        addressTitleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:addressTitleView];
        [addressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_18);
        }];
        
        YYLabel *addressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:address];
        addressView.textAlignment = NSTextAlignmentCenter;
        addressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [bottomView addSubview:addressView];
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(addressTitleView.mas_bottom).offset(YYSIZE_06);
            make.width.mas_offset(YYSIZE_200);
        }];
        
        YYLabel *payTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"您需支付")];
        payTitleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:payTitleView];
        [payTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_15);
        }];
        
        YYLabel *amountView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ff5959 text:[NSString stringWithFormat:@"%@ USDT",amount]];
        amountView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:amountView];
        [amountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(payTitleView.mas_bottom).offset(YYSIZE_05);
        }];
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.top.mas_equalTo(amountView.mas_bottom).offset(YYSIZE_16);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        WDWeakify(self);
        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"复制地址") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:2.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_36);
            make.top.mas_equalTo(cancelView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.confirmBlock) {
                self.confirmBlock(address);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
