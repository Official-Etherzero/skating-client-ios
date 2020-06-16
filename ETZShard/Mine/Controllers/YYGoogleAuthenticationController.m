//
//  YYGoogleAuthenticationController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYGoogleAuthenticationController.h"
#import "YYViewHeader.h"

@interface YYGoogleAuthenticationController ()

@property (nonatomic, strong) YYLabel   *bottomView;
@property (nonatomic, strong) YYLabel   *titleView;
@property (nonatomic, strong) YYLabel   *statusView;
@property (nonatomic, strong) YYButton  *updateBtn;
@property (nonatomic, strong) UISwitch  *gwitch;

@end

@implementation YYGoogleAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"谷歌验证");
    [self initSubViews];
}

- (void)initSubViews {
    
    self.titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_090814 text:YYStringWithKey(@"谷歌验证")];
    [self.view addSubview:self.titleView];
    self.titleView.textAlignment = NSTextAlignmentLeft;
    [self.titleView yy_setWordSpace:0];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_34);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_34);
        }
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_10);
        make.width.mas_offset(YYSIZE_120);
    }];
    
    self.updateBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 title:YYStringWithKey(@"变更谷歌验证") titleColor:COLOR_5d4fe0];
    [self.updateBtn.titleLabel yy_setWordSpace:0];
    self.updateBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.updateBtn];
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_10);
        make.width.mas_offset(YYSIZE_100);
    }];
    
    self.statusView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_090814 text:YYStringWithKey(@"状态")];
    self.statusView.textAlignment = NSTextAlignmentLeft;
    [self.statusView yy_setWordSpace:0];
    [self.view addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView.mas_left);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_50);
        make.width.mas_offset(YYSIZE_100);
    }];
    
    self.gwitch = [[UISwitch alloc] init];
    [self.view addSubview:self.gwitch];
    [self.gwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.updateBtn.mas_right);
        make.centerY.mas_equalTo(self.statusView.mas_centerY);
        make.width.mas_offset(YYSIZE_50);
    }];
    [self.gwitch setOn:NO animated:NO];
    
    
//    self.bottomView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ff4e5b text:YYStringWithKey(@"*基于账户安全，谷歌验证变更后24小时内禁止提现")];
//    [self.view addSubview:self.bottomView];
//    [self.bottomView yy_setWordSpace:0];
//    self.bottomView.textAlignment = NSTextAlignmentCenter;
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (iOS11) {
//            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(YYSIZE_32);
//        } else {
//            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(YYSIZE_32);;
//        }
//    }];
}

#pragma mark - lazy


@end
