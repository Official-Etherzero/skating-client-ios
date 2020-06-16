//
//  WDRobotController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotController.h"
#import "YYUserInfoViewModel.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "UserInfoModel.h"
#import "YYRegisterLoginView.h"
#import "YYToastView.h"
#import "YYNavigationView.h"
#import "RobotTitleView.h"
#import "YYMillViewModel.h"
#import "YYUserDefaluts.h"
#import "RobotTopView.h"
#import "RobotBottomView.h"
#import "RobotMoreFunctionView.h"
#import "MiningInfosModel.h"
#import "CalculateStatisticalModel.h"
#import "WDRobotListController.h"
#import <BlocksKit/BlocksKit.h>
#import "RunningRobotView.h"
#import "RunningRobotModel.h"
#import "WDWalletUserInfo.h"
#import "WDRobotDetailController.h"
#import "RobotMoreFunctionView.h"
#import "WDTabbarController.h"

@interface WDRobotController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) RunningRobotView    *runningRobotView;
@property (nonatomic, strong) YYRegisterLoginView *registerLoginView;
@property (nonatomic, strong) YYNavigationView    *navigationView;
@property (nonatomic, strong) RobotTopView        *topView;
@property (nonatomic, strong) RobotBottomView     *bottomView;
@property (nonatomic, strong) RobotMoreFunctionView *functionView;
@property (nonatomic, strong) YYUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) YYMillViewModel     *millViewModel;
@property (nonatomic, strong) UserInfoModel       *userInfo;
@property (nonatomic, strong) AccountModel        *accountModel;
@property (nonatomic, strong) CalculateStatisticalModel *calculateModel;

@end

@implementation WDRobotController

- (instancetype)initAccountModel:(AccountModel *)model {
    if (self = [super init]) {
        self.accountModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_f5f7fa;
    self.navigationItem.title = YYStringWithKey(@"Robot");
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.accountModel.userId && self.accountModel.userId.length > 1) {
        self.userInfo.UBIAddr = self.accountModel.ubiAddress;
        self.userInfo.UserID = self.accountModel.userId;
    }
    [self getUserInfo];
    [self initViewModel];
}

- (void)initSubViews {
    self.navigationView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    [self.navigationView custom];
    self.navigationView.delegate = self;
    
    self.topView = [[RobotTopView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_220);
    }];
    
    self.bottomView = [[RobotBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    WDWeakify(self);
    self.bottomView.addMinerBlock = ^{
        WDStrongify(self);
        [self enterRobotListController];
    };
    
    self.runningRobotView = [[RunningRobotView alloc] init];
    self.runningRobotView.hidden = YES;
    [self.view addSubview:self.runningRobotView];
    [self.runningRobotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_52);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.runningRobotView.addRobotBlock = ^{
        WDStrongify(self);
        [self enterRobotListController];
    };
    
    self.runningRobotView.selectedRobotBlock = ^(RunningRobotModel * _Nonnull model) {
        WDStrongify(self);
        WDRobotDetailController *vc = [[WDRobotDetailController alloc] initRobotDetailWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.functionView = [[RobotMoreFunctionView alloc] initWithIcons:@[@"jilu",@"huazhan",@"jiangli"] titles:@[@"购买记录",@"划转奖励",@"奖励记录"]];
    self.functionView.hidden = YES;
    self.functionView.selectedTagBlock = ^(NSInteger tag) {
        WDStrongify(self);
        self.functionView.hidden = YES;
        if (tag == 1) {
            [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:1];
        }
    };
}

- (void)enterRobotListController {
    WDRobotListController *vc = [[WDRobotListController alloc] initWithCalculateModel:self.calculateModel ubiAddress:self.accountModel.address];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerAccount {
    WDWeakify(self);
    // 测试地址 0xBA421F8030A8903b0DeB724921B12f1cb3538521
    self.registerLoginView = [YYRegisterLoginView showRegisterLoginViewBlock:^(NSString * _Nonnull inviteCode, NSString * _Nonnull psd, NSString * _Nonnull confirmPsw) {
        if (inviteCode.length == 0) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入邀请码") attachedView:[UIApplication sharedApplication].keyWindow];
            return ;
        }
        if (psd.length == 0 || confirmPsw.length == 0) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if (![psd isEqualToString:confirmPsw]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"请确认密码") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        WDStrongify(self);
        // 注册
        [self.userInfoViewModel yy_viewModelAccountRegisterWithAddress:inviteCode password:psd inviteCode:inviteCode success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[UserInfoModel class]]) {
                self.userInfo = responseObject;
                self.topView.balance = self.userInfo.UBIIN;
                [YYUserDefaluts yy_setValue:psd forkey:KPassword];
                [self initViewModel];
                [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:self.view];
            }
            [self.registerLoginView removeFromSuperview];
            self.registerLoginView = nil;
        } failure:nil];
    } cancelBlock:^{
        WDStrongify(self);
        [self.registerLoginView removeFromSuperview];
        self.registerLoginView = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)getUserInfo {
    WDWeakify(self);
    // 请求个人信息 用户是否注册，并拿取用户数据
    [self.userInfoViewModel yy_viewModelWhetherRegisterWithAddress:self.accountModel.address success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[UserInfoModel class]]) {
            self.userInfo = responseObject;
            self.topView.balance = self.userInfo.UBIIN;
            if (self.accountModel.userId.length == 0) {
                self.accountModel.userId = self.userInfo.UserID;
                self.accountModel.ubiAddress = self.userInfo.UBIAddr;
                [WDWalletUserInfo updateAccount:self.accountModel];
                [self initViewModel];
            }
        } else {
            // 用户未注册
            [self registerAccount];
        }
    } failure:nil];
}

- (void)initViewModel {
    WDWeakify(self);
    // 只有当用户已经注册的时候直接去请求数据
    if (self.userInfo) {
        // 查询矿机统计信息
        [self.millViewModel yy_viewModelKioskOperatorForceOreStatisticsUserId:self.accountModel.userId success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            if ([responseObject isKindOfClass:[CalculateStatisticalModel class]]) {
                self.calculateModel = responseObject;
                self.topView.model = responseObject;
            }
        } failure:nil];
        
        // 正在运行的机器人
        [self.millViewModel yy_viewModelListOfRunningRobotsPageSize:1 currentPage:100 userId:self.userInfo.UserID success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            if ([responseObject isKindOfClass:[NSArray class]]) {
                self.runningRobotView.models = responseObject;
                if (self.runningRobotView.models.count > 0) {
                    self.runningRobotView.hidden = NO;
                }
            }
        } failure:nil];
    }
}


#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)yyNavigationViewConfirmClick:(YYNavigationView *)view {
    self.functionView.hidden = NO;
}

#pragma mark - lazy

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

- (YYMillViewModel *)millViewModel {
    if (!_millViewModel) {
        _millViewModel = [[YYMillViewModel alloc] init];
    }
    return _millViewModel;
}

- (UserInfoModel *)userInfo {
    if (!_userInfo) {
        _userInfo = [[UserInfoModel alloc] init];
    }
    return _userInfo;
}

@end
