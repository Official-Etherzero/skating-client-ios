//
//  YYBindEmailController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYBindEmailController.h"
#import "YYViewHeader.h"
#import "YYCodeInputView.h"
#import "EmailViewModel.h"
#import "YYInterfaceMacro.h"
#import "APIMacro.h"
#import "NSString+Ext.h"
#import "YYToastView.h"

@interface YYBindEmailController ()

@property (nonatomic, strong) EmailViewModel   *viewModel;
@property (nonatomic, strong) YYCodeInputView  *emailView;
@property (nonatomic, strong) YYCodeInputView  *codeView;


@end

@implementation YYBindEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"绑定邮箱");
    [self initSubViews];
}

- (void)initSubViews {
    YYCodeInputView *nameView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"邮箱账号") plcStr:YYStringWithKey(@"请输入邮箱账号")];
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_80);
    }];
    self.emailView = nameView;
    
    YYCodeInputView *codeView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"邮箱验证码") plcStr:YYStringWithKey(@"请输入邮箱y验证码")];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_80);
    }];
    self.codeView = codeView;
    
    YYButton *sendView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 title:YYStringWithKey(@"发送验证码") titleColor:COLOR_5d4fe0];
    [self.view addSubview:sendView];
    [sendView.titleLabel yy_setLineSpace:0];
    sendView.titleLabel.textAlignment = NSTextAlignmentRight;
    [sendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_10);
        make.bottom.mas_equalTo(codeView.mas_bottom).offset(-YYSIZE_10);
    }];
    [sendView addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:YYStringWithKey(@"确认绑定") titleColor:COLOR_ffffff backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
    confirmView.layer.shadowOffset = CGSizeMake(0,4);
    confirmView.layer.shadowOpacity = 1;
    confirmView.layer.shadowRadius = 8;
    [confirmView setBackgroundColor:[UIColor yy_colorGradientChangeWithSize:CGSizeMake(YYSIZE_325, YYSIZE_45) type:YYGradientDirectionVertical startColor:COLOR_e3e3e6 endColor:COLOR_5d4fe0]];
    [self.view addSubview:confirmView];
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    [confirmView addTarget:self action:@selector(bindConfirmClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendClick {
    // 发送验证码 先行为验证
    if (!self.emailView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入邮箱") attachedView:self.view];
        return;
    }
    if (![self.emailView.content yy_isEmail]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱") attachedView:self.view];
        return;
    }
}

- (void)bindConfirmClick {
    if (!self.emailView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入邮箱") attachedView:self.view];
        return;
    }
    if (![self.emailView.content yy_isEmail]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的邮箱") attachedView:self.view];
        return;
    }
    if (!self.codeView.content ||
        self.codeView.content.length != 6) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入6位验证码") attachedView:self.view];
        return;
    }
    [self.viewModel yy_viewModelBindEmailWithEmail:self.emailView.content emailcode:self.codeView.content success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - lazy

- (EmailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[EmailViewModel alloc] init];
    }
    return _viewModel;
}


@end
