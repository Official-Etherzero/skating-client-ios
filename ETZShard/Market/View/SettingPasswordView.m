//
//  SettingPasswordView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SettingPasswordView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"
#import "EVOMd5Generate.h"
#import "YYToastView.h"
#import "NSString+Ext.h"

@interface SettingPasswordView ()

@property (nonatomic,   copy) ConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;
@property (nonatomic, strong) YYSecureView *textView;
@property (nonatomic,   copy) NSString     *textContent;

@end

@implementation SettingPasswordView

+ (instancetype)showSettingPasswordViewBlock:(ConfirmBlock _Nullable)confirmBlock cancelBlock:(CancelBlock _Nullable)cancelBlock {
    SettingPasswordView *view = [[SettingPasswordView alloc] init];
    view.confirmBlock = confirmBlock;
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
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_210);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_132));
        }];
        
        self.textView = [YYSecureView new];
        [bottomView addSubview:self.textView];
        self.textView.inputUnitCount = 12; // 最大 12
        self.textView.unitSpace = 3;
        self.textView.secureTextEntry = YES; // 密文
        self.textView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.cornerRadius = 2.0;
        self.textView.textAlignment = NSTextAlignmentCenter;
        [self.textView setFont:FONT_DESIGN_24];
        self.textView.placeholder = YYStringWithKey(@"请输入交易密码");
        self.textView.alignment = NSTextAlignmentCenter;
        self.textView.placeholderColor = COLOR_1a1a1a_A05;
        self.textView.textColor = COLOR_1a1a1a;
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
        }];
        [self.textView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView.mas_left);
            make.top.mas_equalTo(self.textView.mas_bottom).offset(YYSIZE_20);
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
            make.right.mas_equalTo(self.textView.mas_right);
            make.top.mas_equalTo(cancelView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.textContent.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入交易密码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            [self removeFromSuperview];
            NSString *passwordString = [EVOMd5Generate genMd5:self.textContent];
            if (self.confirmBlock) {
                self.confirmBlock(passwordString);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"secureContent"]) {
        self.textContent = self.textView.secureContent;
    }
}

@end
