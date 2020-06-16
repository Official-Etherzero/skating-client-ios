//
//  YYResetPasswordController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYResetPasswordController.h"
#import "YYViewHeader.h"
#import "YYPlaceholderView.h"
#import "UIView+Ext.h"
#import "YYUserInfoViewModel.h"

@interface YYResetPasswordController ()

@property (nonatomic, strong) YYLabel  *promptLabel;
@property (nonatomic, strong) YYLabel  *confirmLabel;
@property (nonatomic, strong) YYButton *confrimButton;
@property (nonatomic, strong) YYPlaceholderView *passwordView;
@property (nonatomic, strong) YYPlaceholderView *confirmView;
@property (nonatomic, strong) YYUserInfoViewModel *infoModel;
@property (nonatomic,   copy) NSString *mobile;
@property (nonatomic,   copy) NSString *mail;


@end

@implementation YYResetPasswordController

- (instancetype)initResetPswViewControllerWithMobile:(NSString *)mobile {
    if (self = [super init]) {
        self.mobile = mobile;
    }
    return self;
}
- (instancetype)initResetPswViewControllerWithMail:(NSString *)mail {
    if (self = [super init]) {
        self.mail = mail;
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.title = YYStringWithKey(@"重置密码");
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.promptLabel = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_090814 text:YYStringWithKey(@"新登录密码")];
    self.promptLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_30);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_30);
        }
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_25);
        make.size.mas_offset(CGSizeMake(YYSIZE_60, YYSIZE_11));
    }];
    
    self.passwordView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"新登录密码") leftMargin:20.0f];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promptLabel.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_50);
    }];
    
    self.confirmLabel = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_090814 text:YYStringWithKey(@"确认新登录密码")];
    self.confirmLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.confirmLabel];
    [self.confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordView.mas_bottom).offset(YYSIZE_30);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_25);
        make.size.mas_offset(CGSizeMake(YYSIZE_80, YYSIZE_11));
    }];
    
    self.confirmView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"确认新登录密码") leftMargin:20.0f];
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmLabel.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_50);
    }];
    
    self.confrimButton = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:YYSIZE_05];
    self.confrimButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.confrimButton];
    [self.confrimButton yy_setGradientColors:@[(__bridge id)COLOR_ffca46.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
    [self.confrimButton addTarget:self action:@selector(confrimChangePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.confrimButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
}

- (void)confrimChangePassword {
    if (!(self.passwordView.content && self.passwordView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入新的登录密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!(self.confirmView.content && self.confirmView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请确认密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (![self.passwordView.content isEqualToString:self.confirmView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码不一致") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    // 发送修改密码的请求
    if (self.mobile && self.mobile.length > 0) {
        [self.infoModel yy_viewModelResetPasswordByPhoneWithAreaCode:@"86" mobil:self.mobile newPsw:self.confirmView.content success:^(id  _Nonnull responseObject) {
            if (responseObject) {
               [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        } failure:nil];
    } else if (self.mail && self.mail.length > 0) {
       [self.infoModel yy_viewModelResetPasswordByMailWithMail:self.mail newPsw:self.confirmView.content success:^(id  _Nonnull responseObject) {
            if (responseObject) {
               [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        } failure:nil];
    }
}

#pragma mark - laay

- (YYUserInfoViewModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[YYUserInfoViewModel alloc] init];
    }
    return _infoModel;
}


@end
