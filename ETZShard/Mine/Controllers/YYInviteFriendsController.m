//
//  YYInviteFriendsController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYInviteFriendsController.h"
#import "YYViewHeader.h"
#import "UIView+Ext.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYUserInfoViewModel.h"
#import "YYUserDefaluts.h"
#import "YYUserInfoModel.h"
#import "SGQRCodeObtain.h"

@interface YYInviteFriendsController ()

@property (nonatomic, strong) YYLabel *contentView;
@property (nonatomic, strong) YYUserInfoViewModel  *viewModel;
@property (nonatomic, strong) UIImageView  *codeView;

@end

@implementation YYInviteFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    [self initViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)initSubViews {
    UIImageView *bgView = [[UIImageView alloc] init];
    [self.view addSubview:bgView];
    bgView.image = [UIImage imageNamed:@"code_bg"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    YYButton *btnView = [[YYButton alloc] init];
    [btnView setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [self.view addSubview:btnView];
    btnView.stretchLength = 10.0f;
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(YYSIZE_31);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_16);
    }];
    WDWeakify(self);
    [btnView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.image = [UIImage imageNamed:@"code_title"];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_08);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_08);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIImageView *bottomView = [[UIImageView alloc] init];
    bottomView.image = [UIImage imageNamed:@"code_qr"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_18);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.codeView = [[UIImageView alloc] init];
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_70);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_88, YYSIZE_88));
    }];
    
    self.contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_44 textColor:COLOR_fef757 text:@"A236R9"];
    self.contentView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_206);
    }];
    
    YYButton *copyView = [[YYButton alloc] init];
    [self.view addSubview:copyView];
    [copyView setBackgroundImage:[UIImage imageNamed:@"code_btn"] forState:UIControlStateNormal];
    [copyView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_21);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_21);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [copyView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self copyInvilitateContent];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)showCodeViewWithCode:(NSString *)codeString {
    self.codeView.image = [SGQRCodeObtain generateQRCodeWithData:codeString size:YYSIZE_88];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            YYUserInfoModel *infoModel = responseObject;
            WDStrongify(self);
            self.contentView.text = infoModel.InviteCode;
            [self showCodeViewWithCode:[NSString stringWithFormat:@"https://sharding.etherzero.com/ETZ/index.html#/register?invitcode=%@",infoModel.InviteCode]];
        }
    } failure:nil];
}

- (void)copyInvilitateContent {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"https://sharding.etherzero.com/ETZ/index.html#/register?invitcode=%@",self.contentView.text];
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
