//
//  YYLoginController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/19.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLoginController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "APIMacro.h"
#import "RequestModel.h"
#import "UserModel.h"
#import "YYUserDefaluts.h"
#import "YYModel.h"
#import "UsersDefalutMacro.h"
#import "YYMessageViewModel.h"
#import "YYRegisterViewModel.h"
#import "YYLoginViewModel.h"
#import "TerminalModel.h"
#import "YYUserInfoModel.h"

#import "NSString+AES.h"

#import "YYLoginHeaderView.h"
#import "YYLoginView.h"
#import "YYRegisterView.h"
#import "YYToastView.h"

#import "YYRetrievePasswordController.h"
#import "YYPrivacyController.h"
#import "YYRegionController.h"

@interface YYLoginController ()
<YYLoginHeaderViewDelegate,
YYRegisterViewDelegate,
YYLoginViewDelegate>

@property (nonatomic, strong) YYLoginHeaderView    *headerView;
@property (nonatomic, strong) YYLoginView          *loginView;
@property (nonatomic, strong) YYRegisterView       *registerView;
@property (nonatomic, strong) YYLoginViewModel     *loginViewModel;
@property (nonatomic, strong) YYRegisterViewModel  *registerViewModel;
@property (nonatomic, strong) YYMessageViewModel   *messageViewModel;
@property (nonatomic, assign) BOOL                 isChangeLoginView;

@end

@implementation YYLoginController
// 登录注册放一起

- (instancetype)initLoginViewController {
    if (self = [super init]) {
        self.isChangeLoginView = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
}

- (void)initSubViews {
    // 头部视图
    self.headerView = [[YYLoginHeaderView alloc] init];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_20);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_20);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_44);
    }];
    
    // 注册视图
    self.registerView = [[YYRegisterView alloc] init];
    self.registerView.delegate = self;
    [self.view addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.top.mas_equalTo(self.view.mas_top).offset(YYSIZE_100);
    }];
    
    // 登录视图
    self.loginView = [[YYLoginView alloc] init];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.top.mas_equalTo(self.view.mas_top).offset(YYSIZE_100);
    }];
    
    if (self.isChangeLoginView) {
        self.loginView.hidden = NO;
        self.registerView.hidden = YES;
    } else {
        self.registerView.hidden = NO;
        self.loginView.hidden = YES;
    }
}

#pragma mark - YYLoginHeaderViewDelegate

- (void)yy_exitCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - YYRegisterViewDelegate

- (void)yy_showLoginViewHidenRegisterView {
    self.loginView.hidden = NO;
    self.registerView.hidden = YES;
}

// 发验短信验证码
- (void)yy_sendMobileVerificationCodeWithMobile:(NSString *)mobile area:(nonnull NSString *)area {
    [self.messageViewModel yy_viewModelGetSMSCodeWithAreaCode:area mobile:mobile success:^(id  _Nonnull responseObject) {
    } failure:nil];
}

- (void)yy_sendEmailVerificationCodeWithEmail:(NSString *)email {
    [self.messageViewModel yy_viewModelGetMailCodeWithMail:email success:^(id  _Nonnull responseObject) {
    } failure:nil];
}

// 手机注册
- (void)yy_registeAccountMobile:(NSString *)mobile area:(NSString *)area password:(NSString *)password vcode:(NSString *)vcode incode:(NSString *)incode {
    WDWeakify(self);
    [self.registerViewModel yy_viewModelRegisterByPhoneWithPassword:password inviteCode:incode randNum:[TerminalModel getRandNumStr] mobile:mobile verifyCode:vcode success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:[UIApplication sharedApplication].keyWindow];
        }
        WDStrongify(self);
        if (self.loginBlock) {
            self.loginBlock();
        }
        [self yy_exitCurrentController];
    } failure:nil];
}

// 邮箱注册
- (void)yy_registeAccountEmail:(NSString *)email password:(NSString *)password vcode:(NSString *)vcode incode:(NSString *)incode {
    WDWeakify(self);
    [self.registerViewModel yy_viewModelRegisterByMailWithPassword:password inviteCode:incode randNum:[TerminalModel getRandNumStr] mail:email verifyCode:vcode success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:[UIApplication sharedApplication].keyWindow];
        }
        WDStrongify(self);
        if (self.loginBlock) {
            self.loginBlock();
        }
        [self yy_exitCurrentController];
    } failure:nil];
}

#pragma mark - YYLoginViewDelegate

- (void)yy_showRegisterViewHiddenLoginView {
    self.loginView.hidden = YES;
    self.registerView.hidden = NO;
}

- (void)yy_loginViewEnterRegionController {
    [self.navigationController pushViewController:[YYRegionController new] animated:YES];
}

- (void)yy_loginViewEnterForgetController {
    [self.navigationController pushViewController:[[YYRetrievePasswordController alloc] initWithTitle:YYStringWithKey(@"找回密码")] animated:YES];
}

// 这里是直接登录的
- (void)yy_loginViewLoginByPhoneWithArea:(NSString *)area
                                  mobile:(NSString *)mobile
                                password:(NSString *)password {
    WDWeakify(self);
    [self.loginViewModel yy_viewModelLoginByPhoneWithPassword:password mobile:mobile areaCode:area success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"登录成功") attachedView:[UIApplication sharedApplication].keyWindow];
            WDStrongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self yy_exitCurrentController];
        } else {
            NSString *str = responseObject;
            if (str && str.length > 0) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)yy_loginViewLoginByMailWithMail:(NSString *)mail
                               password:(NSString *)password {
    WDWeakify(self);
    [self.loginViewModel yy_viewModelLoginByMailWithPassword:password mail:mail success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"登录成功") attachedView:[UIApplication sharedApplication].keyWindow];
            WDStrongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self yy_exitCurrentController];
        } else {
            NSString *str = responseObject;
            if (str && str.length > 0) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - lazy

- (YYMessageViewModel *)messageViewModel {
    if (!_messageViewModel) {
        _messageViewModel = [[YYMessageViewModel alloc] init];
    }
    return _messageViewModel;
}

- (YYLoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[YYLoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (YYRegisterViewModel *)registerViewModel {
    if (!_registerViewModel) {
        _registerViewModel = [[YYRegisterViewModel alloc] init];
    }
    return _registerViewModel;
}

@end
