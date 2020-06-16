//
//  YYLanguageSettingController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/7.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLanguageSettingController.h"
#import "YYViewHeader.h"
#import "YYLanguageTool.h"
#import "YYLanguageView.h"

@interface YYLanguageSettingController ()
<YYLanguageViewDelegate>

@property (nonatomic, strong) YYLanguageView         *languageView;
@property (nonatomic, assign) YYSettingLanguageType  currentType;

@end

@implementation YYLanguageSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = COLOR_ffffff;
    CGFloat bottomHeight;
    if (IS_IPHONE_X_orMore) {
        bottomHeight = YYSIZE_214;
    } else {
        bottomHeight = YYSIZE_180;
    }
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_offset(bottomHeight);
    }];
    
    YYButton *cancelBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 title:YYStringWithKey(@"取消") titleColor:COLOR_090814_A05];
    [self.view addSubview:cancelBtn];
    cancelBtn.stretchLength = 10.0f;
    [cancelBtn.titleLabel yy_setWordSpace:0];
    cancelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_12);
        make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_15));
    }];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    YYButton *confrimBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 title:YYStringWithKey(@"确定") titleColor:COLOR_5d4fe0];
    [self.view addSubview:confrimBtn];
    confrimBtn.stretchLength = 10.0f;
    [confrimBtn.titleLabel yy_setWordSpace:0];
    confrimBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_12);
        make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_15));
    }];
    [confrimBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_dfe1e6;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bottomView);
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_44);
        make.height.mas_offset(YYSIZE_01);
    }];
    
    self.languageView = [[YYLanguageView alloc] initWithFrame:CGRectMake(0, YYSCREEN_HEIGHT - bottomHeight + YYSIZE_45, YYSCREEN_WIDTH, YYSIZE_135) titles:@[@"中文（简体）",@"中文（繁体）",@"English"] font:FONT_PingFangSC_Medium_26 selectedColor:COLOR_5d4fe0 normalColor:COLOR_090814 selectedbgColor:COLOR_5d4fe0_A005];
    self.languageView.delegate = self;
    [self.view addSubview:self.languageView];
}

- (void)cancelClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmClick {
    [[YYLanguageTool shareInstance] setLanguage:self.currentType];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YYLanguageViewDelegate

- (void)yyLanguageViewDidChangeIndex:(YYLanguageView *)pageView {
    if (pageView.index == 0) {
        // 中文简体
    } else if (pageView.index == 1) {
        // 中文繁体
    } else if (pageView.index == 2) {
        // 英语
    }
}


@end
