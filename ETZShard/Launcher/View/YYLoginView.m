//
//  YYLoginView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/23.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLoginView.h"
#import "YYTouchView.h"
#import "YYViewHeader.h"
#import "YYLoginBottomView.h"
#import "YYPlaceholderView.h"
#import "EVOMd5Generate.h"
#import "NSString+Ext.h"

@interface YYLoginView ()
<YYTouchViewDelegate,
YYLoginBottomViewDelegate>

@property (nonatomic, strong) YYTouchView       *touchView;
@property (nonatomic, strong) YYLoginBottomView *bottomView;
@property (nonatomic, strong) YYPlaceholderView *phoneView;
@property (nonatomic, strong) YYPlaceholderView *emailView;
@property (nonatomic, strong) YYPlaceholderView *passwordView;

@property (nonatomic, strong) YYButton *regionBtn;
@property (nonatomic, strong) YYButton *deAccountBtn;
@property (nonatomic, strong) YYButton *dePasswordBtn;
@property (nonatomic, strong) YYButton *seeBtn;
@property (nonatomic, strong) YYButton *loginBtn;
@property (nonatomic, strong) YYButton *forgetBtn;

@end

@implementation YYLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    // touchView
    self.touchView = [[YYTouchView alloc] initWithFrame:CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_30) titles:@[@"手机登录",@"邮箱登录"]];
    self.touchView.delegate = self;
    [self addSubview:self.touchView];
    
    // 输入框
    // 输入框
    self.phoneView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"手机号") leftMargin:YYSIZE_54];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.touchView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    
    self.regionBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:NO title:@"+86" titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:0];
    [self.phoneView addSubview:self.regionBtn];
    [self.regionBtn addTarget:self action:@selector(regionViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        make.centerY.mas_equalTo(self.phoneView.mas_centerY).offset(YYSIZE_08);
        make.size.mas_offset(CGSizeMake(YYSIZE_24, YYSIZE_10));
    }];
    
    self.emailView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"邮箱账号") leftMargin:YYSIZE_24];
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.touchView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    // 默认显示手机登录
    self.emailView.hidden = YES;
    self.deAccountBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.deAccountBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self addSubview:self.deAccountBtn];
    [self.deAccountBtn addTarget:self action:@selector(deleteAccountClick) forControlEvents:UIControlEventTouchUpInside];
    [self.deAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_24);
        make.centerY.mas_equalTo(self.emailView.mas_centerY).offset(YYSIZE_05);
    }];
    
    self.passwordView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"密码") leftMargin:YYSIZE_24];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.emailView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    
    self.seeBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.seeBtn];
    [self.seeBtn addTarget:self action:@selector(seePasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.seeBtn setImage:[UIImage imageNamed:@"show_icon"] forState:UIControlStateNormal];
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_24);
        make.centerY.mas_equalTo(self.passwordView.mas_centerY).offset(YYSIZE_05);
    }];
    
    self.dePasswordBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.dePasswordBtn];
    [self.dePasswordBtn addTarget:self action:@selector(deletePasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.dePasswordBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.dePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.seeBtn.mas_left).offset(-YYSIZE_10);
        make.centerY.mas_equalTo(self.seeBtn.mas_centerY);
    }];
    
    // 立即登录
    self.loginBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.0f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"立即登录") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
    [self addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(loginViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.passwordView.mas_bottom).offset(YYSIZE_40);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    
    self.forgetBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 title:YYStringWithKey(@"忘记密码?") titleColor:COLOR_5d4fe0];
    [self addSubview:self.forgetBtn];
    [self.forgetBtn addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    // 底部视图
    self.bottomView = [[YYLoginBottomView alloc] initWithTitle:YYStringWithKey(@"没有账号？") des:YYStringWithKey(@"立即注册")];
    self.bottomView.delegate = self;
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self).offset(-YYSIZE_32);
        make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_30));
    }];
}

#pragma mark -

- (void)regionViewClick {
    if ([self.delegate respondsToSelector:@selector(yy_loginViewEnterRegionController)]) {
        [self.delegate yy_loginViewEnterRegionController];
    }
}

- (void)deleteAccountClick {
    self.emailView.content = @"";
}

- (void)seePasswordClick {
    
}

- (void)deletePasswordClick {
    self.passwordView.content = @"";
}

- (void)loginViewClick {
    if (self.touchView.index == 0) {
        // 手机
        if (![self.phoneView.content yy_isPhoneNumber]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        // 密码 md5 加密
        NSString *pswStr = [EVOMd5Generate genMd5:self.passwordView.content];
        if ([self.delegate respondsToSelector:@selector(yy_loginViewLoginByPhoneWithArea:mobile:password:)]) {
            [self.delegate yy_loginViewLoginByPhoneWithArea:@"86" mobile:self.phoneView.content password:pswStr];
        }
    } else {
        // 邮箱
        if (![self.emailView.content yy_isEmail]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱地址") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        // 密码 md5 加密
        NSString *pswStr = [EVOMd5Generate genMd5:self.passwordView.content];
        if ([self.delegate respondsToSelector:@selector(yy_loginViewLoginByMailWithMail:password:)]) {
            [self.delegate yy_loginViewLoginByMailWithMail:self.emailView.content password:pswStr];
        }
    }
}

- (void)forgetPasswordClick {
    [self.delegate yy_loginViewEnterForgetController];
}

#pragma mark - YYLoginBottomViewDelegate

- (void)yy_showRegisterLoginView {
    if ([self.delegate respondsToSelector:@selector(yy_showRegisterViewHiddenLoginView)]) {
        [self.delegate yy_showRegisterViewHiddenLoginView];
    }
}

#pragma mark - YYTouchViewDelegate

- (void)yy_touchViewDidChangeIndex:(YYTouchView *)touchView {
    if (touchView.index == 0) {
        // 手机号登录
        self.phoneView.hidden = NO;
        self.emailView.hidden = YES;
    } else {
        // 邮箱登录
        self.phoneView.hidden = YES;
        self.emailView.hidden = NO;
    }
}

@end
