//
//  YYBindGoogleValidatorController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYBindGoogleValidatorController.h"

#import "YYInterfaceMacro.h"
#import "YYViewHeader.h"
#import "YYPlaceholderView.h"

#import "YYGoogleAuthenticationController.h"
#import "RequestModel.h"
#import "YYMessageView.h"
#import "YYEnum.h"
#import "YYMessageAuthenticateController.h"

@interface YYBindGoogleValidatorController ()

@property (nonatomic, strong) YYPlaceholderView *codeView;
@property (nonatomic, strong) YYButton          *confirmBtn;
@property (nonatomic, strong) YYButton          *downloadBtn;
@property (nonatomic, strong) YYMessageView     *messageView;

@end

@implementation YYBindGoogleValidatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews {
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_090814 text:YYStringWithKey(@"谷歌验证码")];
    [self.view addSubview:titleView];
    [titleView yy_setWordSpace:0];
    titleView.textAlignment = NSTextAlignmentLeft;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(12);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_30);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_30);
        }
        make.size.mas_offset(CGSizeMake(60, 11));
    }];
    
    self.codeView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入6位谷歌验证码") leftMargin:8.5f];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_offset(YYSIZE_40);
    }];
    
    self.confirmBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_7a6cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认开启") titleColor:COLOR_ffffff backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
    [self.confirmBtn yy_setGradientColors:@[(__bridge id)COLOR_7a6cff.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
    self.confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(YYSIZE_35);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    [self.confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.downloadBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"下载谷歌验证器") titleColor:COLOR_5d4fe0];
    [self.view addSubview:self.downloadBtn];
    self.downloadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_45);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_45);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_offset(YYSIZE_100);
    }];
    [self.downloadBtn addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirmClick {
    if (self.codeView.content.length < 1) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入谷歌验证码") attachedView:self.view];
        return;
    }
    NSArray *types = @[@(VALIDATE_MODE_MOBILE)];
    YYMessageAuthenticateController *vc = [[YYMessageAuthenticateController alloc] initWithCodeTypes:types];
    self.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有 ios8 later
    vc.modalPresentationCapturesStatusBarAppearance = YES;
    vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    WDWeakify(self);
    vc.handeCodeBlock = ^(NSArray * _Nonnull codes) {
        NSString *mobileCode = codes.firstObject;
//        WDStrongify(self);
//        [self.viewModel yy_viewModelBindGoogleWithCode:self.codeView.content mobilecode:mobileCode success:^(id responseObject) {
//            RequestModel *model = responseObject;
//            [YYToastView showCenterWithTitle:[YYLanguagePackManager yy_getValueStringWithKey:model.ErrCode] attachedView:[UIApplication sharedApplication].keyWindow];
//        } failure:nil];
    };

//    [self.navigationController pushViewController:[[YYGoogleAuthenticationController alloc] initWithTitle:YYStringWithKey(@"谷歌验证")] animated:YES];
}

- (void)downloadClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id388497605"]];
}

#pragma mark - lazy


@end
