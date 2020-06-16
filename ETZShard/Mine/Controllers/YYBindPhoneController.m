//
//  YYBindPhoneController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYBindPhoneController.h"
#import "YYViewHeader.h"
#import "YYCodeInputView.h"
#import "MessageViewModel.h"
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "APIMacro.h"
#import "RequestModel.h"

@interface YYBindPhoneController ()
@property (nonatomic, strong) YYCodeInputView   *nameView;
@property (nonatomic, strong) YYCodeInputView   *codeView;
@property (nonatomic, strong) MessageViewModel  *viewModel;

@end

@implementation YYBindPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"绑定手机");
    [self initSubViews];
}

- (void)initSubViews {
    YYCodeInputView *nameView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"手机账号") plcStr:YYStringWithKey(@"请输入手机账号")];
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
    self.nameView = nameView;
    
    YYCodeInputView *codeView = [[YYCodeInputView alloc] initCodeInputViewWithTitle:YYStringWithKey(@"手机验证码") plcStr:YYStringWithKey(@"请输入手机验证码")];
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
    if (!self.nameView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入手机号") attachedView:self.view];
        return;
    }
//    if (![self.nameView.content yy_isIphone]) {
//        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:self.view];
//        return;
//    }
//    WDWeakify(self);
//    [YYVerificationView showVerificationViewWithBlock:^(NSString * _Nonnull verificate) {
//        WDStrongify(self);
//        [self.viewModel yy_viewModelMessageWithTokenMachine:verificate Type:kTypeBindmobile area:@"86" mobile:self.nameView.content success:^(id responseObject) {
//        } failure:nil];
//    }];
}

- (void)bindConfirmClick {
    if (!self.nameView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入手机号") attachedView:self.view];
        return;
    }
//    if (![self.nameView.content yy_isIphone]) {
//        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:self.view];
//        return;
//    }
    if (!self.codeView.content ||
        self.codeView.content.length != 6) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入6位验证码") attachedView:self.view];
        return;
    }
    WDWeakify(self);
    [self.viewModel yy_viewModelBindMobile:self.nameView.content area:@"86" mobileCode:self.codeView.content success:^(id responseObject) {
        RequestModel *model = responseObject;
//        if ([model.ErrMsg isEqualToString:@"2008"]) {
//            WDStrongify(self);
//            [YYToastView showCenterWithTitle:YYStringWithKey(@"绑定成功") attachedView:[UIApplication sharedApplication].keyWindow show:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        } else {
//            [YYToastView showCenterWithTitle:[YYLanguagePackManager yy_getValueStringWithKey:responseObject] attachedView:[UIApplication sharedApplication].keyWindow];
//        }
    } failure:nil];
}

#pragma mark - lazy

- (MessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageViewModel alloc] init];
    }
    return _viewModel;
}


@end
