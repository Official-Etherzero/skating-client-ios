//
//  YYWithdrawalView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYWithdrawalView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYTextView.h"
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"
#import "EVOMd5Generate.h"
#import "NSString+Ext.h"
#import "YYUserDefaluts.h"

@interface YYWithdrawalView ()

@property (nonatomic, strong) YYTextView              *chargeView;
@property (nonatomic, strong) YYTextView              *addressView;
@property (nonatomic, strong) YYSecureView            *passwordView;
@property (nonatomic,   copy) WithdrawalConfirmBlock  confirmBlock;
@property (nonatomic,   copy) WithdrawalCancelBlock   cancelBlock;
@property (nonatomic,   copy) NSString                *password;

@end

@implementation YYWithdrawalView

- (void)dealloc {
    [self.passwordView removeObserver:self forKeyPath:@"secureContent"];
}

+ (instancetype)showWithdrawalViewBlock:(WithdrawalConfirmBlock)block
                            cancelBlock:(WithdrawalCancelBlock _Nullable)cancelBlock {
    YYWithdrawalView *view = [[YYWithdrawalView alloc] init];
    view.confirmBlock = block;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)init {
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
            make.centerY.mas_equalTo(self.mas_centerY).offset(-YYSIZE_80);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_273));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_1a1a1a text:YYStringWithKey(@"提现")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_18);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        NSString *fee = [NSString stringWithFormat:@"%@%@",YYStringWithKey(@"提现手续费"),@"%5"];
        if ([YYUserDefaluts yy_getWithdrawalPoundage]) {
            fee = [NSString stringWithFormat:@"%@%@",YYStringWithKey(@"提现手续费"),[YYUserDefaluts yy_getWithdrawalPoundage]];
        }
        YYLabel *poundageView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ff5959 text:fee];
        [bottomView addSubview:poundageView];
        poundageView.textAlignment = NSTextAlignmentCenter;
        [poundageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_08);
        }];
        
        YYTextView *dataView = [YYTextView new];
        dataView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        [bottomView addSubview:dataView];
        dataView.layer.borderWidth = 0.5;
        dataView.layer.cornerRadius = 2.0;
        dataView.textAlignment = NSTextAlignmentLeft;
        dataView.font = FONT_DESIGN_24;
        dataView.placeholder = YYStringWithKey(@"数量");
        dataView.placeholderColor = COLOR_1a1a1a_A03;
        dataView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(poundageView.mas_bottom).offset(YYSIZE_18);
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_170, YYSIZE_31));
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_22 textColor:COLOR_1a1a1a text:@"ETZ"];
        [bottomView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(dataView.mas_centerY);
            make.left.mas_equalTo(dataView.mas_right).offset(YYSIZE_06);
        }];
        
        YYTextView *addressView = [YYTextView new];
        addressView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        [bottomView addSubview:addressView];
        addressView.layer.borderWidth = 0.5;
        addressView.layer.cornerRadius = 5.0;
        addressView.textAlignment = NSTextAlignmentLeft;
        addressView.font = FONT_DESIGN_24;
        addressView.placeholder = YYStringWithKey(@"请输入提币地址");
        addressView.placeholderColor = COLOR_1a1a1a_A03;
        addressView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dataView.mas_bottom).offset(YYSIZE_10);
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
        }];
        self.addressView = addressView;
        
        
        YYSecureView *passwordView = [YYSecureView new];
        passwordView.inputUnitCount = 12; // 最大 12
        passwordView.unitSpace = 3;
        passwordView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        [bottomView addSubview:passwordView];
        passwordView.layer.borderWidth = 0.5;
        passwordView.layer.cornerRadius = 2.0;
        passwordView.secureTextEntry = YES; // 密文
        passwordView.backgroundColor = COLOR_ffffff;
        passwordView.textColor = COLOR_1a1a1a;
        passwordView.textAlignment = NSTextAlignmentLeft;
        passwordView.font = FONT_DESIGN_24;
        passwordView.placeholder = YYStringWithKey(@"请输入密码");
        passwordView.placeholderColor = COLOR_1a1a1a_A03;
        passwordView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_10);
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
        }];
        self.passwordView = passwordView;
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.top.mas_equalTo(self.passwordView.mas_bottom).offset(YYSIZE_20);
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
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:2.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_36);
            make.top.mas_equalTo(cancelView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (dataView.text.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入提现金额") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (!self.addressView.text) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入提币地址") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (![self.addressView.text yy_isEtherAddress]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的提币地址") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (!self.passwordView.secureContent) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (self.confirmBlock) {
                NSString *password = [EVOMd5Generate genMd5:self.password];
                if (self.confirmBlock) {
                    self.confirmBlock(dataView.text, addressView.text,password);
                }
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.passwordView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
    }
    return self;
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:self.passwordView]) {
        if ([keyPath isEqualToString: @"secureContent"]) {
            self.password = self.passwordView.secureContent;
        }
    }
}
@end
