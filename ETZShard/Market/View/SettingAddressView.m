//
//  SettingAddressView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SettingAddressView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"

@interface SettingAddressView ()
<UITextViewDelegate>

@property (nonatomic,   copy) ConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;
@property (nonatomic, strong) YYTextView   *textView;
@property (nonatomic,   copy) NSString     *textContent;

@end

@implementation SettingAddressView

+ (instancetype)showSettingAddressViewBlock:(ConfirmBlock _Nullable)confirmBlock cancelBlock:(CancelBlock _Nullable)cancelBlock {
    SettingAddressView *view = [[SettingAddressView alloc] init];
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
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_175));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:YYStringWithKey(@"为了保证交易正常进行")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_16);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:YYStringWithKey(@"请先设置你的USDT(ETH)收款地址")];
        contentView.numberOfLines = 0;
        contentView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_05);
        }];
        
        self.textView = [YYTextView new];
        self.textView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        self.textView.placeholder = YYStringWithKey(@"USDT(ETH)收款地址");
        self.textView.placeholderColor= COLOR_1a1a1a_A03;
        self.textView.delegate = self;
        [bottomView addSubview:self.textView];
        self.textView.layer.borderWidth = 0.5;
        self.textView.layer.cornerRadius = 5.0;
        self.textView.textAlignment = NSTextAlignmentCenter;
        [self.textView setFont:FONT_DESIGN_24];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
        }];
        
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
            [self removeFromSuperview];
            if (self.confirmBlock) {
                self.confirmBlock(self.textContent);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.textContent = textView.text;
}


@end
