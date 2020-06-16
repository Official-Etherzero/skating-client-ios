//
//  WDMarketController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDMarketController.h"
#import "YYViewHeader.h"
#import "MarketFuctionView.h"
#import "MarketMiddleView.h"
#import "PayListView.h"
#import "SellListView.h"
#import "TransferView.h"
#import "YYPayViewModel.h"
#import "YYSellViewModel.h"
#import "OrderModel.h"
#import "YYInterfaceMacro.h"
#import "YYUserInfoViewModel.h"
#import "YYUserDefaluts.h"
#import "UIImage+Ext.h"
#import "WDOrderTaskController.h"
#import "UIViewController+Ext.h"
#import "HangBuyController.h"
#import "OnSaleController.h"
#import "WDOrderDetailController.h"
#import "WDBuyCoinController.h"
#import "WDSellCoinController.h"
#import "WalletDataManager.h"
#import "WDWalletUserInfo.h"
#import "UserInfoModel.h"
#import "YYRegisterLoginView.h"
#import "YYToastView.h"
#import "OrderDetailModel.h"
#import "WDOrderStatusController.h"
#import "WDSendViewController.h"
#import "ClientEtherAPI.h"
#import "SettingPasswordView.h"
#import "WDTabbarController.h"

#define RobotAddress         @"0x69948e7dC1536Fc083DA5D85eedaE6bCE930b19a"

@interface WDMarketController ()
<MarketFuctionViewDelegate,
MarketMiddleViewDelegate>

@property (nonatomic, strong) MarketFuctionView *functionView;
@property (nonatomic, strong) MarketMiddleView  *middleView;
@property (nonatomic, strong) PayListView       *payListView;
@property (nonatomic, strong) SellListView      *sellListView;
@property (nonatomic, strong) TransferView      *transferView;
@property (nonatomic, strong) YYRegisterLoginView *registerLoginView;

@property (nonatomic, strong) YYPayViewModel    *payViewModel;
@property (nonatomic, strong) YYSellViewModel   *sellViewModel;
@property (nonatomic, strong) YYUserInfoViewModel *infoViewModel;
@property (nonatomic, strong) NSArray<OrderModel *>* orders;
@property (nonatomic, strong) AccountModel      *model;
@property (nonatomic, strong) UserInfoModel     *userInfo;

@end

@implementation WDMarketController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self yy_hideTabBar:NO];
    self.navigationController.navigationBar.hidden = NO;
    // 判断当前是否有注册过
    self.model = [WalletDataManager accountModel];
    // 每次进入页面需要重新拿数据
    [self initViewModel];
    if (!(self.model.userId && self.model.userId.length > 1)) {
        // 当前账号可能未注册，需判断当前账户是否注册
        WDWeakify(self);
        [self.infoViewModel yy_viewModelWhetherRegisterWithAddress:self.model.address success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            if ([responseObject isKindOfClass:[UserInfoModel class]]) {
                self.userInfo = responseObject;
                self.model.userId = self.userInfo.UserID;
                self.model.ubiAddress = self.userInfo.UBIAddr;
                [WDWalletUserInfo updateAccount:self.model];
            } else {
                [self registerAccount];
            }
        } failure:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"Market");
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyAccountBalanceChange:) name:kAPIAccountModel object:nil];
}

- (void)initSubViews {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage yy_imageRenderOriginalWithName:@"more"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(moreButtonClick)];
    
    self.functionView = [[MarketFuctionView alloc] init];
    self.functionView.delegate = self;
    [self.view addSubview:self.functionView];
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_62));
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    
    self.middleView = [[MarketMiddleView alloc] init];
    [self.view addSubview:self.middleView];
    self.middleView.delegate = self;
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.functionView.mas_bottom);
        make.height.mas_offset(YYSIZE_37);
    }];
    
    self.payListView = [[PayListView alloc] init];
    [self.view addSubview:self.payListView];
    [self.payListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    WDWeakify(self);
    self.payListView.buyBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        [self.payViewModel yy_viewModelBuyDetailWithAddress:self.model.address orderId:model.OrderID success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[OrderDetailModel class]]) {
                [self.navigationController pushViewController:[[WDBuyCoinController alloc] initViewControllerWithOrderModel:model detail:responseObject] animated:YES];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
        
    };
    
    self.sellListView = [[SellListView alloc] init];
    [self.view addSubview:self.sellListView];
    self.sellListView.hidden = YES;
    [self.sellListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.sellListView.sellBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        [self.sellViewModel yy_viewModelSaleDetailWithAddress:self.model.address orderId:model.OrderID success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[OrderDetailModel class]]) {
                [self.navigationController pushViewController:[[WDSellCoinController alloc] initViewControllerWithOrderModel:model detail:responseObject] animated:YES];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
    };
    
    self.transferView = [[TransferView alloc] init];
    [self.view addSubview:self.transferView];
    self.transferView.hidden = YES;
    [self.transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.transferView.transferBlock = ^(float ubi, TransferType type) {
        WDStrongify(self);
        // 1表示从场内到场外，2从场外到场内
        switch (type) {
            case TRANSFER_TRA_WALLET:{
                // 交易账户到钱包
                [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
                    [self.infoViewModel yy_viewModelTransferWithdrawalWithAmout:ubi address:self.model.address password:psd success:^(id  _Nonnull responseObject) {
                        if ([responseObject isKindOfClass:[BlanceModel class]]) {
                            self.transferView.model = responseObject;
                            [YYToastView showCenterWithTitle:YYStringWithKey(@"提现成功") attachedView:self.view];
                        } else {
                            [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                        }
                    } failure:nil];
                } cancelBlock:nil];
            }
                break;
            case TRANSFER_TRA_ROBOT:{
               // 交易账户到机器人
                [self transferUbi:ubi direction:1];
            }
                break;
            case TRANSFER_ROB_TRANSFER:{
                // 机器人到交易账户
                [self transferUbi:ubi direction:2];
            }
                break;
            case TRANSFER_WAL_ROBOT:{
                // 钱包到机器人
                [ClientEtherAPI yy_getTransactionCostWithFromAddress:self.model.address toAddress:RobotAddress dataString:@"" money:[NSString stringWithFormat:@"%f",ubi] success:^(NSString * _Nonnull gasPrice, NSString * _Nonnull gasLimit, NSString * _Nonnull cost) {
                    WDStrongify(self);
                    dispatch_async_main_safe((^{
                        [self yy_hideTabBar:YES];
                        WDSendViewController *vc = [[WDSendViewController alloc] initWithTransferToAddress:RobotAddress gasPrice:gasPrice gasLimit:gasLimit transferAmount:[NSString stringWithFormat:@"%f",ubi] cost:@"0"];
                        vc.exitBlock = ^{
                            [self yy_hideTabBar:NO];
                        };
                        self.definesPresentationContext = YES;
                        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                        vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
                        [self.navigationController presentViewController:vc animated:YES completion:nil];
                    }));
                } failure:^(NSError * _Nonnull error) {
                    WDStrongify(self);
                    if (self.view) {
                        [YYToastView showCenterWithTitle:YYStringWithKey(@"gasLimit 评估出错") attachedView:self.view];
                    }
                }];
            }
                break;
                
            default:
                break;
        }
    };
}

- (void)transferUbi:(float)ubi direction:(NSInteger)direction {
    WDWeakify(self);
    [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.infoViewModel yy_viewModelTransferUBIWithDirection:direction count:ubi address:self.model.address password:psd success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[BlanceModel class]]) {
                self.transferView.model = responseObject;
                [YYToastView showCenterWithTitle:YYStringWithKey(@"划转成功") attachedView:self.view];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
    } cancelBlock:nil];
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
        [self.infoViewModel yy_viewModelAccountRegisterWithAddress:self.model.address password:psd inviteCode:inviteCode success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[UserInfoModel class]]) {
                self.userInfo = responseObject;
                [YYUserDefaluts yy_setValue:psd forkey:KPassword];
                [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:self.view];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
            [self.registerLoginView removeFromSuperview];
            self.registerLoginView = nil;
        } failure:nil];
    } cancelBlock:^{
        WDStrongify(self);
        [self.registerLoginView removeFromSuperview];
        self.registerLoginView = nil;
        [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:0];
    }];
}

- (void)moreButtonClick {
    WDOrderTaskController *vc = [[WDOrderTaskController alloc] initWithTitle:YYStringWithKey(@"Market")];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initViewModel {
    // 买单
    WDWeakify(self);
    [self.payViewModel yy_viewModelListOrdersWithPage:0 pageSize:100 success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.payListView.models = responseObject;
        }
    } failure:nil];
    
    // 卖单
    [self.sellViewModel yy_viewModelListOrdersWithPage:0 pageSize:100 success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.sellListView.models = responseObject;
        }
    } failure:nil];
    
    // 查询余额
    [self.infoViewModel yy_viewModelCheckBalancesWithUserID:self.model.userId success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[BlanceModel class]]) {
            WDStrongify(self);
            self.transferView.model = responseObject;
        }
    } failure:nil];
    
    // 判断是否有正在进行的任务
    NSString *address = [WalletDataManager accountModel].address;
    [self.infoViewModel yy_viewModelGetListOrdersWithPage:0 pageSize:100 address:address type:1 success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.orders = responseObject;
            if (self.orders && self.orders.count > 0) {
                // 当前是否有未完成的订单
                [self.middleView outstandingOrders:YES];
            } else {
                [self.middleView outstandingOrders:NO];
            }
        }
    } failure:nil];
}

#pragma mark -notify

- (void)onNotifyAccountBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIAccountModelInfo];
    dispatch_async_main_safe(^{
        if ([model.address isEqualToString:self.model.address]) {
            // 单一去赋值
            self.model.balance = model.balance;
            self.transferView.blance = model.balance;
        }
    });
}

#pragma mark - lazy

- (YYPayViewModel *)payViewModel {
    if (!_payViewModel) {
        _payViewModel = [[YYPayViewModel alloc] init];
    }
    return _payViewModel;
}

- (YYSellViewModel *)sellViewModel {
    if (!_sellViewModel) {
        _sellViewModel = [[YYSellViewModel alloc] init];
    }
    return _sellViewModel;
}

- (YYUserInfoViewModel *)infoViewModel {
    if (!_infoViewModel) {
        _infoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _infoViewModel;
}

#pragma mark - MarketMiddleViewDelegate

- (void)yy_selectedOrderDetailView {
    OrderModel *model = self.orders.lastObject;
    [self.navigationController pushViewController:[[WDOrderStatusController alloc] initViewControllerWithModel:model] animated:YES];
}

- (void)yy_selectedPayOrderView {
    [self.navigationController pushViewController:[[HangBuyController alloc] initHangBuyViewControllerWithAddress:self.model.address] animated:YES];
}

- (void)yy_selectedSellOrderView {
    [self.navigationController pushViewController:[[OnSaleController alloc] initOnSaleViewControllerWithAddress:self.model.address] animated:YES];
}

#pragma mark - MarketFuctionViewDelegate

- (void)yy_showPageViewIndex:(NSInteger)index {
    self.payListView.hidden = index == 0 ? NO : YES;
    self.sellListView.hidden = index == 1 ? NO : YES;
    self.transferView.hidden = index == 2 ? NO : YES;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"Market"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"Market_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"市场");
}

@end
