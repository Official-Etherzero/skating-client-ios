//
//  YYRegisterView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/23.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYRegisterView.h"
#import "YYTouchView.h"
#import "YYViewHeader.h"
#import "YYLoginBottomView.h"
#import "YYPlaceholderView.h"
#import "YYToastView.h"
#import "EVOMd5Generate.h"
#import "YYGCDTimer.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"

@interface YYRegisterView ()
<YYTouchViewDelegate,
YYLoginBottomViewDelegate>

@property (nonatomic, strong) YYTouchView       *touchView;
@property (nonatomic, strong) YYLoginBottomView *bottomView;
@property (nonatomic, strong) YYButton          *regionButton;
@property (nonatomic, strong) YYButton          *seeButton;
@property (nonatomic, strong) YYButton          *coverButton;
@property (nonatomic, strong) YYButton          *codeButton;
@property (nonatomic, strong) YYButton          *addButton;
@property (nonatomic, strong) YYButton          *packUpButton;
@property (nonatomic, strong) YYButton          *resButton;
@property (nonatomic, strong) YYLabel           *codeView;
@property (nonatomic, strong) YYPlaceholderView *invitationView;
@property (nonatomic, strong) YYPlaceholderView *phoneView;
@property (nonatomic, strong) YYPlaceholderView *emailView;
@property (nonatomic, strong) YYPlaceholderView *passwordView;
@property (nonatomic, strong) YYPlaceholderView *confirmView;
@property (nonatomic, strong) YYPlaceholderView *verificationView;
@property (nonatomic, strong) YYLabel           *timeView;
@property (nonatomic,   copy) NSString          *gcdTimer;
@property (nonatomic, assign) NSInteger         currentCount;
@end

@implementation YYRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    // touchView
    self.touchView = [[YYTouchView alloc] initWithFrame:CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_30) titles:@[@"手机注册",@"邮箱注册"]];
    self.touchView.delegate = self;
    [self addSubview:self.touchView];
    // 输入框
    YYPlaceholderView *phoneView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请输入您的手机号") leftMargin:YYSIZE_54];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.touchView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.phoneView = phoneView;
    
    self.regionButton = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:NO title:@"+86" titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:0];
    [phoneView addSubview:self.regionButton];
    [self.regionButton addTarget:self action:@selector(regionViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.regionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        make.centerY.mas_equalTo(phoneView.mas_centerY).offset(YYSIZE_08);
        make.size.mas_offset(CGSizeMake(YYSIZE_24, YYSIZE_10));
    }];
    
     YYPlaceholderView *emailView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请输入您的邮箱") leftMargin:YYSIZE_24];
    [emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.touchView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.emailView = emailView;
    // 默认显示手机注册
    self.emailView.hidden = YES;
    
    // 密码框
    YYPlaceholderView *passwordView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请输入8-16位密码") leftMargin:YYSIZE_24];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(emailView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.passwordView = passwordView;
    
    self.seeButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.seeButton];
    [self.seeButton addTarget:self action:@selector(seePasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.seeButton setImage:[UIImage imageNamed:@"show"] forState:UIControlStateNormal];
    [self.seeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_24);
        make.centerY.mas_equalTo(passwordView.mas_centerY).offset(YYSIZE_05);
        make.size.mas_offset(CGSizeMake(YYSIZE_20, YYSIZE_20));
    }];
    
    YYPlaceholderView *confirmView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请确认上面的密码") leftMargin:YYSIZE_24];
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(passwordView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.confirmView = confirmView;
    
    self.coverButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.coverButton];
    [self.coverButton addTarget:self action:@selector(hiddenPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.coverButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_24);
        make.centerY.mas_equalTo(confirmView.mas_centerY).offset(YYSIZE_05);
        make.size.mas_offset(CGSizeMake(YYSIZE_20, YYSIZE_20));
    }];
    
    // 获取验证码
    YYPlaceholderView *verificationView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请输入验证码") leftMargin:YYSIZE_24];
    [verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(confirmView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.verificationView = verificationView;
    self.codeButton = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"获取验证码") titleColor:COLOR_5d4fe0];
    [self addSubview:self.codeButton];
    [self.codeButton addTarget:self action:@selector(handleVerificateCodeClick) forControlEvents:UIControlEventTouchUpInside];
    self.codeButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verificationView.mas_centerY).offset(YYSIZE_05);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_70, YYSIZE_12));
    }];
    
    self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_5d4fe0 text:@"60s"];
    [self addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verificationView.mas_centerY).offset(YYSIZE_05);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_12));
    }];
    self.timeView.hidden = YES;
    
    // 邀请码
    YYPlaceholderView *invitationView = [[YYPlaceholderView alloc] initWithAttackView:self plcStr:YYStringWithKey(@"请输入邀请码") leftMargin:YYSIZE_24];
    [invitationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(verificationView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.invitationView = invitationView;
    
    // 立即注册
    self.resButton = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.0f borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:YYStringWithKey(@"立即注册") titleColor:COLOR_ffffff backgroundColor:COLOR_e3e3e6 cornerRadius:5.0f];
    [self addSubview:self.resButton];
    [self.resButton addTarget:self action:@selector(registeAccountClick) forControlEvents:UIControlEventTouchUpInside];
    [self.resButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_381);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    
    // 底部视图
    self.bottomView = [[YYLoginBottomView alloc] initWithTitle:YYStringWithKey(@"已有账号？") des:YYStringWithKey(@"立即登录")];
    self.bottomView.delegate = self;
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self).offset(-YYSIZE_32);
        make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_30));
    }];
    
    [self.touchView setIndex:0];
}

#pragma mark - method

- (void)regionViewClick {
    if ([self.delegate respondsToSelector:@selector(yy_enterRegionController)]) {
        [self.delegate yy_enterRegionController];
    }
}

- (void)seePasswordClick {
    // 显示密码
}

- (void)hiddenPasswordClick {
    // 密码改成密文
}

- (void)handleVerificateCodeClick {
    if (self.touchView.index == 0) {
        if (![self.phoneView.content yy_isPhoneNumber]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号码") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        // 发短信验证码
        if ([self.delegate respondsToSelector:@selector(yy_sendMobileVerificationCodeWithMobile:area:)]) {
            [self.delegate yy_sendMobileVerificationCodeWithMobile:self.phoneView.content area:@"86"];
        }
    } else {
        if (![self.emailView.content yy_isEmail]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        // 发邮件验证码
        if ([self.delegate respondsToSelector:@selector(yy_sendEmailVerificationCodeWithEmail:)]) {
            [self.delegate yy_sendEmailVerificationCodeWithEmail:self.emailView.content];
        }
    }
    self.codeButton.hidden = YES;
    self.timeView.hidden = NO;
    self.currentCount = 60;
    self.gcdTimer = [YYGCDTimer timerTask:self selector:@selector(openFire) start:0 interval:1.0f repeats:YES async:YES];
}

-(void)openFire {
    if (self.currentCount == 1) {
        [YYGCDTimer canelTimer:self.gcdTimer];
        dispatch_async_main_safe(^{
            self.codeButton.hidden = NO;
            self.timeView.hidden = YES;
        });
        return;
    }
    self.currentCount --;
    dispatch_async_main_safe((^{
        self.timeView.text = [NSString stringWithFormat:@"%lds",(long)self.currentCount];
    }));
}

- (void)showInvitationView {
    self.packUpButton.hidden =  self.invitationView.hidden = NO;
    self.codeView.hidden = self.addButton.hidden = YES;
}

- (void)hiddenInvitationView {
    self.codeView.hidden = self.addButton.hidden = NO;
    self.packUpButton.hidden =  self.invitationView.hidden = YES;
}

- (void)registeAccountClick {
    if (self.touchView.index == 0) {
        // 手机
        if (!self.phoneView.content) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入手机号码") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if (![self.phoneView.content yy_isPhoneNumber]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号码") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
    } else if (self.touchView.index == 1) {
        // 邮箱
        if (!self.emailView.content) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入邮箱地址") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if (![self.emailView.content yy_isEmail]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱地址") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
    }
    if (!self.passwordView.content) {
       [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入8~16位密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!self.confirmView.content) {
       [YYToastView showCenterWithTitle:YYStringWithKey(@"请确认密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (![self.passwordView.content isEqualToString:self.confirmView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码错误") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!self.verificationView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入验证码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!self.invitationView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入邀请码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    // 密码 md5 加密
    NSString *pswStr = [EVOMd5Generate genMd5:self.passwordView.content];
    if (self.touchView.index == 0) {
        // 手机注册 测试阶段默认是中国区 86
        if ([self.delegate respondsToSelector:@selector(yy_registeAccountMobile:area:password:vcode:incode:)]) {
            [self.delegate yy_registeAccountMobile:self.phoneView.content area:@"86" password:pswStr vcode:self.verificationView.content incode:self.invitationView.content];
        }
    } else if (self.touchView.index == 1){
        // 邮箱注册
        if ([self.delegate respondsToSelector:@selector(yy_registeAccountEmail:password:vcode:incode:)]) {
            [self.delegate yy_registeAccountEmail:self.emailView.content password:pswStr vcode:self.verificationView.content incode:self.invitationView.content];
        }
    }
}

- (void)privacyViewClick {
    if ([self.delegate respondsToSelector:@selector(yy_enterPrivacyController)]) {
        [self.delegate yy_enterPrivacyController];
    }
}

#pragma mark - YYLoginBottomViewDelegate

- (void)yy_showRegisterLoginView {
    if ([self.delegate respondsToSelector:@selector(yy_showLoginViewHidenRegisterView)]) {
        [self.delegate yy_showLoginViewHidenRegisterView];
    }
}

#pragma mark - YYTouchViewDelegate

- (void)yy_touchViewDidChangeIndex:(YYTouchView *)touchView {
    if (touchView.index == 0) {
        // 手机号注册
        self.phoneView.hidden = NO;
        self.emailView.hidden = YES;
    } else {
        // 邮箱注册
        self.phoneView.hidden = YES;
        self.emailView.hidden = NO;
    }
}

@end
