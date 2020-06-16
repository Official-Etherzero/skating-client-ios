//
//  YYChangePasswordController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYChangePasswordController.h"
#import "YYViewHeader.h"
#import "YYCodeInputView.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"
#import "YYToastView.h"

@interface YYChangePasswordController ()

@property (nonatomic, strong) YYCodeInputView    *oldPsdView;
@property (nonatomic, strong) YYCodeInputView    *nPsdView;
@property (nonatomic, strong) YYCodeInputView    *confrimView;
@property (nonatomic, strong) YYButton           *bindButton;
@property (nonatomic, strong) YYLabel            *desView;

@end

@implementation YYChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"修改登录密码");
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
}

- (void)initSubViews {
    self.oldPsdView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"旧密码") plcStr:YYStringWithKey(@"请输入原密码")];
    self.nPsdView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"新密码") plcStr:YYStringWithKey(@"请输入格式为6-20位数字+字母组合的新登录密码")];
    self.confrimView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"确认新密码") plcStr:YYStringWithKey(@"请再次确认新登录密码")];
    
    self.bindButton = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:YYStringWithKey(@"确认绑定") titleColor:COLOR_ffffff backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
    self.bindButton.layer.shadowOffset = CGSizeMake(0,4);
    self.bindButton.layer.shadowOpacity = 1;
    self.bindButton.layer.shadowRadius = 8;
    [self.bindButton setBackgroundColor:[UIColor yy_colorGradientChangeWithSize:CGSizeMake(YYSIZE_325, YYSIZE_45) type:YYGradientDirectionVertical startColor:COLOR_e3e3e6 endColor:COLOR_5d4fe0]];
    [self.bindButton addTarget:self action:@selector(updateConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    
//    self.desView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ff4e5b text:YYStringWithKey(@"*基于账户安全，密码修改后24小时内禁止提现")];
    
    [self.view addSubview:self.oldPsdView];
    [self.view addSubview:self.nPsdView];
    [self.view addSubview:self.confrimView];
    [self.view addSubview:self.bindButton];
    [self.view addSubview:self.desView];
    [self addConstraint];
}

- (void)addConstraint {
    [self.oldPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_80);
    }];
    
    [self.nPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldPsdView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_80);
    }];
    
    [self.confrimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nPsdView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_80);
    }];
    
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confrimView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
}

- (void)updateConfirmClick {
    if (!self.oldPsdView.content
        || !self.nPsdView.content
        || !self.confrimView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:self.view];
        return;
    }
    if ([self.oldPsdView.content isEqualToString:self.nPsdView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"新密码和旧密码相同") attachedView:self.view];
        return;
    }
    if (![self.confrimView.content isEqualToString:self.nPsdView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码错误") attachedView:self.view];
        return;
    }
    // 校验密码是不是 6~20 位字母和数字组合
    // 这里需要判断下密码是不是有问题
//    WDWeakify(self);
//    [YYVerificationView showVerificationViewWithBlock:^(NSString * _Nonnull verificate) {
//        WDStrongify(self);
//        [self.viewModel yy_viewModelUpdatePasswordWithMachineCode:verificate oldpassword:self.oldPsdView.content newpassword:self.nPsdView.content googlecode:@"" mobilecode:@"" emailcode:@"" success:^(id responseObject) {
//        } failure:^(NSError *error) {
//        }];
//    }];
}

#pragma mark - lazy


@end
