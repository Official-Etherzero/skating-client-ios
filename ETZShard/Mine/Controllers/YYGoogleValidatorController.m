//
//  YYGoogleValidatorController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/4.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYGoogleValidatorController.h"
#import "YYInterfaceMacro.h"
#import "YYViewHeader.h"
#import "SGQRCodeObtain.h"

#import "RequestModel.h"
#import "GoogleModel.h"

#import "YYToastView.h"
#import "UIView+Ext.h"
#import "UILabel+Ext.h"

#import "YYBindGoogleValidatorController.h"

@interface YYGoogleValidatorController ()

@property (nonatomic, strong) YYLabel         *titleView;
@property (nonatomic, strong) UIImageView     *imageView;
@property (nonatomic, strong) YYButton        *nextStepBtn;
@property (nonatomic, strong) YYButton        *downloadBtn;
@property (nonatomic, strong) YYButton        *cpbutton;

@end

@implementation YYGoogleValidatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"绑定谷歌验证");
    [self initSubViews];
    [self initDatas];
}

- (void)initSubViews {
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_47);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_25);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_25);
        }
        make.size.mas_offset(CGSizeMake(YYSIZE_125, YYSIZE_125));
    }];
    
    self.titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_5d4fe0 text:@""];
    [self.view addSubview:self.titleView];
    [self.titleView yy_setWordSpace:0];
    self.titleView.textAlignment = NSTextAlignmentLeft;
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_top).offset(YYSIZE_35);
        make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_16);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    self.cpbutton = [[YYButton alloc] initWithFont:FONT_DESIGN_24 borderWidth:0 borderColoer:COLOR_5d4fe0_A010.CGColor masksToBounds:YES title:YYStringWithKey(@"复制私钥") titleColor:COLOR_5d4fe0 backgroundColor:COLOR_5d4fe0_A010 cornerRadius:2.0f];
    [self.view addSubview:self.cpbutton];
    [self.cpbutton addTarget:self action:@selector(copytitleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cpbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView.mas_left);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_25);
        make.size.mas_offset(CGSizeMake(YYSIZE_70, YYSIZE_25));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(26,243,326,60.5);
    label.numberOfLines = 0;
    [self.view addSubview:label];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"•  请将上面的密钥复制或扫码添加到谷歌验证器\n•  请妥善备份保管好密钥，用于手机更换或遗失时恢复谷歌验证器" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:9/255.0 green:8/255.0 blue:20/255.0 alpha:1.0]}];
    label.attributedText = titleString;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(YYSIZE_29);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_326, YYSIZE_62));
    }];
    
    self.nextStepBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_7a6cff.CGColor masksToBounds:YES title:YYStringWithKey(@"已保存，下一步") titleColor:COLOR_ffffff backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
    [self.nextStepBtn yy_setGradientColors:@[(__bridge id)COLOR_7a6cff.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
    self.nextStepBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(YYSIZE_29);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    [self.nextStepBtn addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)initDatas {
//    WDWeakify(self);
//    [self.viewModel yy_viewModelGoogleDetailSuccess:^(id responseObject) {
//        WDStrongify(self);
//        if ([responseObject isKindOfClass:[RequestModel class]]) {
//            RequestModel *model = responseObject;
//            [YYToastView showCenterWithTitle:[YYLanguagePackManager yy_getValueStringWithKey:model.ErrCode] attachedView:[UIApplication sharedApplication].keyWindow];
//        } else {
//            GoogleModel *model = responseObject;
//            self.titleView.text = model.google_key;
//            self.imageView.image = [SGQRCodeObtain generateQRCodeWithData:model.img size:YYSIZE_125];
//        }
//    } failure:^(NSError *error) {
//        WDStrongify(self);
//        if (self.view) {
//            [YYToastView showCenterWithTitle:YYStringWithKey(@"网络错误") attachedView:[UIApplication sharedApplication].keyWindow];
//        }
//    }];
}

- (void)copytitleClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.titleView.text;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view];
}

- (void)nextStepClick {
    [self.navigationController pushViewController:[[YYBindGoogleValidatorController alloc] initWithTitle:YYStringWithKey(@"绑定谷歌验证")] animated:YES];
}

- (void)downloadClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id388497605"]];
}

#pragma mark - lazy


@end
