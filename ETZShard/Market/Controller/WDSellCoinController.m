//
//  WDSellCoinController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDSellCoinController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"
#import "NSString+Ext.h"
#import "SellDetailView.h"
#import "YYSellViewModel.h"
#import "AccountModel.h"
#import "YYTextView.h"
#import "PayUsdtView.h"
#import "SettingPasswordView.h"
#import "OrderDetailModel.h"
#import "WalletDataManager.h"
#import "SettingAddressView.h"

@interface WDSellCoinController ()

@property (nonatomic, strong) OrderModel  *model;
@property (nonatomic, strong) YYButton    *cancelTransferView;
@property (nonatomic, strong) YYButton    *confirmPayView;
@property (nonatomic, strong) YYButton    *cancelView;
@property (nonatomic, strong) YYButton    *confrimView;
@property (nonatomic, strong) YYButton    *statusTitleView;
@property (nonatomic, strong) YYSellViewModel  *viewModel;
@property (nonatomic, strong) AccountModel     *accountModel;
@property (nonatomic, strong) OrderDetailModel *detailModel;
@property (nonatomic, strong) SellDetailView   *detailView;

@end

@implementation WDSellCoinController

- (instancetype)initViewControllerWithOrderModel:(OrderModel *)model detail:(OrderDetailModel *)detail; {
    if (self = [super init]) {
        self.model = model;
        self.detailModel = detail;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"Sell");
    self.accountModel = [WalletDataManager accountModel];
    [self initSubViews];
}

- (void)initSubViews {
    self.detailView = [[SellDetailView alloc] initWithOrderModel:self.model];
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_370));
    }];
    WDWeakify(self);
    self.detailView.dismissBlock = ^{
        WDStrongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    // 取消出售
    self.cancelView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消出售") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.cancelView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cancelView];
    [self.cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_30);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [self.cancelView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.viewModel yy_viewModelSaleCancelWithAddress:self.accountModel.address orderId:self.detailModel.OrderID success:^(id  _Nonnull responseObject) {
        } failure:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 确认出售
    self.confrimView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认挂售") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
    self.confrimView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.confrimView];
    [self.confrimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelView.mas_top);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [self.confrimView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self showSettingPasswordView];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.statusTitleView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_1a1a1a_A03.CGColor masksToBounds:YES title:YYStringWithKey(@"已支付") titleColor:COLOR_1a1a1a_A05 backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.statusTitleView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusTitleView];
    [self.statusTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    self.statusTitleView.enabled = NO;
    self.statusTitleView.hidden = YES;
}

- (void)showSettingPasswordView {
    if (self.detailModel.USDTAddr && self.detailModel.USDTAddr.length > 0) {
        [self confirmSale];
    } else {
        // 设置 USDT 地址
        WDWeakify(self);
        [SettingAddressView showSettingAddressViewBlock:^(NSString * _Nonnull address) {
            WDStrongify(self);
            [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
                [self.viewModel yy_viewModelSetUsdtAddressWithAddress:self.accountModel.address password:psd usdtAddress:address success:^(id  _Nonnull responseObject) {
                    if ([responseObject isEqualToString:@"0"]) {
                        // 设置成功
                        [YYToastView showCenterWithTitle:YYStringWithKey(@"设置 USDT 地址成功") attachedView:self.view show:^{
                            [self confirmSale];
                        }];
                    } else {
                        [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                    }
                } failure:nil];
            } cancelBlock:nil];
        } cancelBlock:nil];
    }
}

- (void)confirmSale {
    WDWeakify(self);
    [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.viewModel yy_viewModelConfirmBuyWithAddress:self.accountModel.address password:psd orderId:self.detailModel.OrderID success:^(id  _Nonnull responseObject) {
            if ([responseObject isEqualToString:@"0"]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"确认成功") attachedView:self.view];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
    } cancelBlock:nil];
}

#pragma mark -

- (YYSellViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYSellViewModel alloc] init];
    }
    return _viewModel;
}

- (OrderDetailModel *)detailModel {
    if (!_detailModel) {
        _detailModel = [[OrderDetailModel alloc] init];
    }
    return _detailModel;
}

@end
