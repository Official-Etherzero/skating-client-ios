//
//  YYMineController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/18.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYMineController.h"
#import "YYViewHeader.h"
#import "YYUserHeaderView.h"
#import "YYUserListView.h"
#import "YYToastView.h"
#import "UIViewController+Ext.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "YYInterfaceMacro.h"
#import "YYLoginController.h"
#import "YYUserInfoViewModel.h"
#import "UserListViewModel.h"
#import "YYUserDefaluts.h"
#import "WDTabbarController.h"
#import "WDWalletUserInfo.h"
#import "WalletDataManager.h"

#import "YYRealNameCertificationController.h"

@interface YYMineController ()
<YYUserListViewDelegate>

@property (nonatomic, strong) YYUserHeaderView    *headView;
@property (nonatomic, strong) YYUserListView      *listView;
@property (nonatomic, strong) YYButton            *backBtn;
@property (nonatomic, strong) YYUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) UserListViewModel   *userListViewModel;

@end

@implementation YYMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self updateDatas];
    [self yy_hideTabBar:NO];
}

- (void)initSubViews {
    
    self.headView = [[YYUserHeaderView alloc] init];
    [self.view addSubview:self.headView];
    self.headView.backgroundColor = COLOR_ffffff;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(YYSIZE_20);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).mas_offset(YYSIZE_20);
        }
        make.height.mas_offset(YYSIZE_80);
    }];
    
    self.backBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_5d4fe0.CGColor masksToBounds:YES title:YYStringWithKey(@"退出登录") titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            // 83;
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_28);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_28);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        // height 45
        make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
    }];
    [self.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.listView = [[YYUserListView alloc] init];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    self.listView.backgroundColor = [UIColor greenColor];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom).offset(YYSIZE_05);
        make.bottom.mas_equalTo(self.backBtn.mas_top).offset(-YYSIZE_10);
    }];
}

- (void)updateDatas {
    WDWeakify(self);
    [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            WDStrongify(self);
            self.headView.infoModel = responseObject;
        }
    } failure:nil];

    [UserListViewModel yy_viewModelGetListViewDatasBlock:^(SettingDataSource * _Nonnull dataSource) {
        WDStrongify(self);
        self.listView.dataSource = dataSource;
    }];
}

- (void)backClick {
    // 清理缓存
    [self clearCache];
    [self dismissLoginView];
}

- (void)dismissLoginView {
    YYLoginController *vc = [YYLoginController new];
    [self presentViewController:vc animated:YES completion:nil];
    vc.loginBlock = ^{
        [UIApplication sharedApplication].delegate.window.rootViewController
        = [WDTabbarController setupViewControllersWithIndex:0];
    };
    WDWeakify(self);
    vc.dismissBlock = ^{
        WDStrongify(self);
        [self dismissLoginView];
    };
}

- (void)clearCache {
    // 清除缓存
    [YYUserDefaluts yy_setIsRealName:NO];
    [YYUserDefaluts yy_removeAccessTokenCache];
    [YYUserDefaluts yy_clearCurrentWalletAddressCache];
//    [WDWalletUserInfo removeAccount:[WalletDataManager accountModel]];
}

#pragma mark - YYUserListViewDelegate

- (void)yy_clickViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[YYRealNameCertificationController class]]) {
        if ([YYUserDefaluts yy_getIsRealName]) {
            return;
        }
    }
    if (vc) {
       [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazy

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"me"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"me_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"我的");
}

@end
