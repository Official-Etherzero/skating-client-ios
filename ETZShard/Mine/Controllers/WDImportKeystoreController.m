//
//  WDImportKeystoreController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDImportKeystoreController.h"
#import "YYToastView.h"
#import "YYViewHeader.h"

#import "UILabel+Ext.h"


@interface WDImportKeystoreController ()

@property (nonatomic, strong) AccountModel   *model;
@property (nonatomic,   copy) NSString       *topTitle;
@property (nonatomic, strong) UIButton       *cpButton;

@end

@implementation WDImportKeystoreController

- (instancetype)initWithAccountModel:(AccountModel *)model topTitle:(nonnull NSString *)topTitile {
    if (self = [super init]) {
        self.model = model;
        self.topTitle = topTitile;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = self.topTitle;
    [self initSubViews];
}

- (void)initSubViews {
    
    YYLabel *contentView = [YYLabel new];
    [self.view addSubview:contentView];
    contentView.numberOfLines = 0;
    contentView.textColor = COLOR_1a1a1a;
    contentView.font = FONT_DESIGN_26;
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth = 1;
    contentView.layer.cornerRadius = 2;
    contentView.layer.borderColor = COLOR_1a1a1a.CGColor;
    contentView.text = self.model.keyStore;
    if (self.model.keyStore &&
        self.model.keyStore.length >0) {
        [contentView yy_setLineSpace:6];
    }
    contentView.textInsets = UIEdgeInsetsMake(22, 23, 21, 22);
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_offset(YYSIZE_331);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_25);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_25);
        }
    }];
    [contentView yy_adaptContentFitHeight];
    
    self.cpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.cpButton];
    [self.cpButton.titleLabel setFont:FONT_DESIGN_30];
    [self.cpButton setBackgroundColor:COLOR_3d5afe];
    [self.cpButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.cpButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.cpButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.cpButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.cpButton.layer setMasksToBounds:YES];
    self.cpButton.layer.cornerRadius = 5.0f;
    [self.cpButton setTitle:YYStringWithKey(@"复制Keystore") forState:UIControlStateNormal];
    [self.cpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_bottom).offset(YYSIZE_25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
    }];
    [self.cpButton addTarget:self action:@selector(copyPrivateKeyClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)copyPrivateKeyClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.keyStore;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view];
}


@end
