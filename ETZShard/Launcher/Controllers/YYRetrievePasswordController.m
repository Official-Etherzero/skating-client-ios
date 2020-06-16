//
//  YYRetrievePasswordController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/19.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYRetrievePasswordController.h"
#import "YYViewHeader.h"
#import "YYPlaceholderView.h"
#import "YYPageView.h"
#import "UIView+Ext.h"
#import "YYResetPasswordController.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYCodeView.h"
#import "YYMessageViewModel.h"
#import "YYEnum.h"
#import "MessageView.h"
#import "NSString+Ext.h"

@interface YYRetrievePasswordController ()
<YYPageViewDelegate>

@property (nonatomic, strong) YYPageView         *pageView;
@property (nonatomic, strong) YYPlaceholderView  *emailView;
@property (nonatomic, strong) YYPlaceholderView  *phoneView;
@property (nonatomic, strong) YYButton           *nextStep;
@property (nonatomic, strong) YYLabel            *warningView;
@property (nonatomic, strong) YYMessageViewModel *viewModel;

@end

@implementation YYRetrievePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    if (IS_IPHONE_X_orMore) {
        self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, 88, YYSCREEN_WIDTH, YYSIZE_50) titles:@[@"邮箱方式",@"手机方式"] font:FONT_PingFangSC_Medium_30 selectedColor:COLOR_090814 normalColor:COLOR_090814_A05 sliderColor:COLOR_5d4fe0];
    } else {
        self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, 64, YYSCREEN_WIDTH, YYSIZE_50) titles:@[@"邮箱方式",@"手机方式"] font:FONT_PingFangSC_Medium_30 selectedColor:COLOR_090814 normalColor:COLOR_090814_A05 sliderColor:COLOR_5d4fe0];
    }
    self.pageView.delegate = self;
    self.pageView.index = 0;
    [self.view addSubview:self.pageView];
    
    self.emailView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入邮箱账号") leftMargin:YYSIZE_25];
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_60);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_60);
        }
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_50));
        make.left.mas_equalTo(self.view);
    }];
    
    self.phoneView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入手机号") leftMargin:YYSIZE_25];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailView.mas_top);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_50));
        make.left.mas_equalTo(self.view);
    }];
    self.phoneView.hidden = YES;
    
    self.nextStep = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"下一步") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:YYSIZE_05];
    self.nextStep.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.nextStep yy_setGradientColors:@[(__bridge id)COLOR_ffca46.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
    [self.view addSubview:self.nextStep];
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    WDWeakify(self);
    [self.nextStep bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.emailView resignFirstResponder];
        [self.phoneView resignFirstResponder];
        NSString *title;
        if (self.pageView.index == 0) {
            // 邮箱验证码
            if (![self.emailView.content yy_isEmail]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱地址") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            title = YYStringWithKey(@"邮箱验证码");
        } else {
            // 短信验证码
            title = YYStringWithKey(@"短信验证码");
            if (![self.phoneView.content yy_isPhoneNumber]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
        }
        [self showCodeViewTitle:title];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)showCodeViewTitle:(NSString *)title {
    WDWeakify(self);
    [MessageView showMessageViewTitle:title SendBlock:^{
        WDStrongify(self);
        [self getCodeAction];
    } confirmBlock:^(NSString * _Nonnull codeStr) {
        [self VerifyCodeAction:codeStr];
    }];
}

- (void)getCodeAction {
    if (self.pageView.index == 0) {
        [self.viewModel yy_viewModelGetMailCodeWithMail:self.emailView.content success:^(id  _Nonnull responseObject) {

        } failure:nil];
    } else {
        [self.viewModel yy_viewModelGetSMSCodeWithAreaCode:@"86" mobile:self.phoneView.content success:^(id  _Nonnull responseObject) {
            
        } failure:nil];
    }
}

- (void)VerifyCodeAction:(NSString *)codeStr {
    WDWeakify(self);
    if (self.pageView.index == 0) {
        [self.viewModel yy_viewModelVerifyMailWithMail:self.emailView.content verifyCode:codeStr success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            [self enterResetPasswordVC];
        } failure:nil];
    } else {
        [self.viewModel yy_viewModelVerifySMSCodeWithAreaCode:@"86" mobile:self.phoneView.content verifyCode:codeStr success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            [self enterResetPasswordVC];
        } failure:nil];
    }
}

- (void)enterResetPasswordVC {
    YYResetPasswordController *vc = [YYResetPasswordController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (YYMessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYMessageViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - YYPageViewDelegate

- (void)pageViewDidChangeIndex:(YYPageView *)pageView {
    if (pageView.index == 0) {
        self.emailView.hidden = NO;
        self.phoneView.hidden = YES;
    } else {
        self.emailView.hidden = YES;
        self.phoneView.hidden = NO;
    }
}

@end
