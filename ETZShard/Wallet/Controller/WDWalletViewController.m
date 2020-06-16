//
//  WDWalletViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDWalletViewController.h"

#import "WDAddTokenController.h"
#import "WDTokenDetailsController.h"
#import "WDScanCodeController.h"
#import "WDCollectionController.h"
#import "WDTransferController.h"
#import "WDRobotController.h"
#import "WDWalletListController.h"
#import "WDCreateWalletController.h"

#import "AccountModel.h"
#import "WalletDataManager.h"
#import "LocalServer.h"
#import "WDWalletUserInfo.h"
#import "YYDateModel.h"
#import "YYUserDefaluts.h"
#import "ClientServer.h"
#import "HSEther.h"
#import "ClientServer.h"
#import "YYExchangeRateModel.h"
#import "WalletDataManager.h"
#import "YYUserInfoViewModel.h"
#import "YYUserInfoModel.h"
#import "WDImportWalletController.h"
#import "WDPersonalWalletDetailController.h"

#import "WalletHeaderView.h"
#import "YYInterfaceMacro.h"
#import "UIViewController+CWLateralSlide.h"
#import "YYAlertView+Ext.h"
#import "TokenListView.h"
#import "YYViewHeader.h"
#import "APINotifyCenter.h"
#import "YYAddress.h"
#import "UIViewController+Ext.h"
#import "YYToastView.h"
#import "YYFunctionView.h"
#import "NodeAssetsView.h"

#import "HSEther.h"

#import "TerminalModel.h"
#import "NSString+AES.h"

@interface WDWalletViewController ()
<TokenListViewDelegate,
YYFunctionViewDelegate>

@property (nonatomic, strong) NSMutableArray         *addresses;
@property (nonatomic,   copy) NSString               *praviteString;
@property (nonatomic, strong) WalletHeaderView       *headerView;
@property (nonatomic, strong) YYFunctionView         *functionView;
@property (nonatomic, strong) TokenListView          *listView;
@property (nonatomic, strong) AccountModel           *account;
@property (nonatomic,   copy) NSArray<RateModel *>   *rateModels;
@property (nonatomic, strong) NodeAssetsView         *nodeAssetsView;
@property (nonatomic, strong) YYUserInfoViewModel    *viewModel;
@property (nonatomic,   copy) NSString               *nodeAddress;

@end

/** 进入钱包就一直需要去刷新代币的价格*/

@implementation WDWalletViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_ffffff;
    [super viewDidLoad];
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyAccountBalanceChange:) name:kAPIAccountModel object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
    [self initialDatas];
}

- (void)initialDatas {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            YYUserInfoModel *model = responseObject;
            WDStrongify(self);
            self.nodeAssetsView.balance = model.ETZ;
            if (![YYUserDefaluts yy_getIsRealName] && model.IsTrueName == 1) {
                [YYUserDefaluts yy_setIsRealName:YES];
            }
            // 如果没有绑定钱包则去创建钱包。
            // 如果绑定了钱包但是没导入，需要去导入已绑定的钱包
            if (model.WalletAddr.length == 0) {
                WDCreateWalletController *createWalletVC = [[WDCreateWalletController alloc] init];
                [self.navigationController pushViewController:createWalletVC animated:YES];
            } else {
                NSArray *objs = [WalletDataManager getAccountsForDataBase];
                if (objs.count == 0) {
                    [self importBindWalletWithModel:model];
                } else {
                    for (AccountModel *account in objs) {
                        if ([account.address isEqualToString:model.WalletAddr]) {
                            self.account = account;
                            [YYUserDefaluts yy_setCurrentWalletAddress:account.address];
                            [self showWalletAddress];
                            return;
                        }
                    }
                    [self importBindWalletWithModel:model];
                }
            }
            [self showWalletAddress];
        }
    } failure:nil];
}

- (void)showWalletAddress {
    self.headerView.model = self.account;
    [[APINotifyCenter shardInstance] startNotify];
//    WDWeakify(self);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        WDStrongify(self);
//        [self getAccountModel];
//        if (self.account) {
//        }
//    });
}

- (void)importBindWalletWithModel:(YYUserInfoModel *)model {
    WDWeakify(self);
    [YYToastView showCenterWithTitle:YYStringWithKey(@"请导入您已绑定的钱包") attachedView:[UIApplication sharedApplication].keyWindow show:^{
        WDStrongify(self);
        WDImportWalletController *vc = [[WDImportWalletController alloc] initBindWalletWithAddress:model.WalletAddr];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)initSubViews {
    // HeaderView
    self.headerView = [[WalletHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_220);
    }];
    WDWeakify(self);
    self.headerView.enterWalletBlock = ^{
        WDStrongify(self);
        if (self.account) {
            WDPersonalWalletDetailController *vc = [[WDPersonalWalletDetailController alloc] initWithAccountModel:self.account];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    NSArray *titles = [WalletDataManager funcTitles];
    NSArray *images = [WalletDataManager funcImages];
    self.functionView = [[YYFunctionView alloc] initWithImages:images titles:titles];
    self.functionView.delegate = self;  
    [self.view addSubview:self.functionView];
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_85));
        make.bottom.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_39);
    }];
    
    // ListView
    self.listView = [[TokenListView alloc] init];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.functionView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_138);
    }];
    
    self.nodeAssetsView = [[NodeAssetsView alloc] init];
    [self.view addSubview:self.nodeAssetsView];
    [self.nodeAssetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.listView.mas_bottom);
        make.height.mas_offset(YYSIZE_138);
    }];
}

- (void)getAccountModel {
    if ([WDWalletUserInfo allObjects].count > 0) {
        NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
        self.account = [WalletDataManager getAccountsForDataBase][index];
    }
}

- (void)getExchangeRates {
    WDWeakify(self);
    [[ClientServer sharedInstance] getRatesComplete:^(NSArray<RateModel *> * _Nonnull rates, float usdt, NSError * _Nonnull error) {
        NSLog(@"rates = %@,usdt = %f,error = %@",rates,usdt,error);
        WDStrongify(self);
        if (rates) {
            self.rateModels = [YYExchangeRateModel yy_exchangeRateByModels:rates usdtPrice:usdt];
            NSLog(@"%@",self.rateModels);
            [[NSNotificationCenter defaultCenter] postNotificationName:kExchageRate object:nil userInfo:@{kExchageRateInfo:self.rateModels}];
        }
    }];
}

#pragma mark - YYFunctionViewDelegate

- (void)yy_functionClickWithCurrentIndex:(NSUInteger)index {
    NSString *title = [WalletDataManager funcTitles][index];
    switch (index) {
        case 0: // 扫一扫
        {
            WDWeakify(self)
            [LocalServer syncAVCaptureDeviceForAuthorizationCompleteHandler:^(NSError * _Nonnull error) {
                WDStrongify(self)
                if (error == nil) {
                    [self.navigationController pushViewController:[[WDScanCodeController alloc] initWithTitle:title] animated:YES];
                }
            }];
        }
            break;
        case 1: // 转账
        {
            WDTransferController *vc = [[WDTransferController alloc] initWithTitle:title];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: // 收款
        {
            [self.navigationController pushViewController:[[WDCollectionController alloc] initWithTitle:title] animated:YES];
        }
            break;
        case 3: // 机器人
        {
            WDRobotController *vc = [[WDRobotController alloc] initAccountModel:self.account];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark = lazy

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark -notify

- (void)onNotifyAccountBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIAccountModelInfo];
    dispatch_async_main_safe(^{
        if ([model.address isEqualToString:self.account.address]) {
            // 单一去赋值
            self.account.balance = model.balance;
            self.headerView.model = self.account;
            self.listView.model = self.account;
        }
    });
}

#pragma mark - TokenListViewDelegate

- (void)yy_openAddTokenViewController {
    [self.navigationController pushViewController:[WDAddTokenController new] animated:YES];
}

- (void)yy_openTokenDetailsViewControllerWithItem:(TokenItem *)item {
    WDTokenDetailsController *dvc = [[WDTokenDetailsController alloc] initWithTokenItem:item];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"asset"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"asset_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"资产");
}

@end
