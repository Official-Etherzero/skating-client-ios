//
//  WDOrderStatusController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDOrderStatusController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"
#import "NSString+Ext.h"
#import "OrderStatusView.h"
#import "YYPayViewModel.h"
#import "YYSellViewModel.h"
#import "WalletDataManager.h"
#import "SettingPasswordView.h"

@interface WDOrderStatusController ()

@property (nonatomic, strong) OrderModel      *model;
@property (nonatomic, strong) YYButton        *cancelView;
@property (nonatomic, strong) YYButton        *statusView;
@property (nonatomic, strong) YYButton        *confirmView;
@property (nonatomic, strong) YYSellViewModel *sellViewModel;
@property (nonatomic, strong) YYPayViewModel  *payViewModel;
@property (nonatomic, strong) AccountModel    *accountModel;
@property (nonatomic, strong) OrderStatusView *detailView;

@end

@implementation WDOrderStatusController

- (instancetype)initViewControllerWithModel:(OrderModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = self.model.direction == 1 ? YYStringWithKey(@"Sell") : YYStringWithKey(@"Buy");
    self.accountModel = [WalletDataManager accountModel];
    [self initSubViews];
}

- (void)initSubViews {
    
    self.detailView = [[OrderStatusView alloc] initWithOrderModel:self.model];
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
    
    // 取消交易
    self.cancelView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消交易") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.cancelView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cancelView ];
    [self.cancelView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    [self.cancelView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self cancelTrasnferaction];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"我已收到买家 USDT") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.confirmView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.confirmView ];
    [self.confirmView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    [self.confirmView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self confirmTrasnferactionWithStatus:1];
    } forControlEvents:UIControlEventTouchUpInside];
    self.confirmView.hidden = YES;
    
    self.statusView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_1a1a1a_A03.CGColor masksToBounds:YES title:@"" titleColor:COLOR_1a1a1a_A05 backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.statusView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusView ];
    [self.statusView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    self.statusView .enabled = NO;
    self.statusView.hidden = YES;
    
    if (self.model.Status == 0) {
        self.detailView.senconds = 30;
    } else if (self.model.Status == 1 || self.model.Status == 2) {
        if ([self.accountModel.userId isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.model.UserID]]) {
            // 此订单是自己创建的，被别人锁定了，将不能被操作
            if (self.model.Status == 1) {
                // 1 分钟
                [self.detailView hiddenTimeView];
                NSString *title = self.model.direction == 1 ? YYStringWithKey(@"等待卖家确认") : YYStringWithKey(@"等待买家确认");
                [self.statusView setTitle:title forState:UIControlStateNormal];
            } else {
                // 15 分钟
                [self.detailView hiddenTimeView];
//                NSString *title = self.model.direction == 1 ? YYStringWithKey(@"等待卖家付款") : YYStringWithKey(@"等待买家付款");
                [self.statusView setTitle:YYStringWithKey(@"等待买家付款") forState:UIControlStateNormal];
            }
            self.cancelView.hidden = YES;
            self.statusView.hidden = NO;
        } else {
            if (self.model.Status == 1) {
                // 1 分钟
                self.detailView.senconds = 60;
            } else {
                // 15 分钟
                self.detailView.senconds = 900;
            }
        }
    } else {
        if (self.model.Status == 3) {
            // 60 分钟 // 如果是自己的订单需要自己去确认
            if ([self.accountModel.userId isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.model.UserID]]) {
                // 确定是否完成
                self.confirmView.hidden = NO;
                self.detailView.senconds = 3600;
                [self.cancelView setTitle:YYStringWithKey(@"我未收到买家 USDT") forState:UIControlStateNormal];
            } else {
                self.cancelView.hidden = YES;
                self.statusView.hidden = NO;
                [self.detailView hiddenTimeView];
                [self.statusView setTitle:YYStringWithKey(@"等待卖家确认交易") forState:UIControlStateNormal];
            }
        } else if (self.model.Status == 4) {
            // 隐藏时间
            [self.detailView hiddenTimeView];
            self.cancelView.hidden = YES;
            self.statusView.hidden = NO;
            if ([self.accountModel.userId isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.model.UserID]]) {
                [self.statusView setTitle:YYStringWithKey(@"交易失败，未收到买家 USDT") forState:UIControlStateNormal];
            } else {
                [self.statusView setTitle:YYStringWithKey(@"交易失败，卖家没收到 USDT") forState:UIControlStateNormal];
            }
        }
    }
}

- (void)confirmTrasnferactionWithStatus:(NSInteger)status {
    WDWeakify(self);
    [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        // 1 成功 其它失败
        [self.sellViewModel yy_viewModelConfrimOrderWithAddress:self.accountModel.address orderId:self.model.OrderID password:psd status:status success:^(id  _Nonnull responseObject) {
            if ([responseObject isEqualToString:@"0"]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"确认成功") attachedView:self.view show:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
        
    } cancelBlock:nil];
}

- (void)cancelTrasnferaction {
    // 当状态值是 0 的时候
    if (self.model.Status == 0) {
        WDWeakify(self);
        if (self.model.direction == 1) {
            // 出售
            [self.sellViewModel yy_viewModelSaleCancelWithAddress:self.accountModel.address orderId:self.model.OrderID success:^(id  _Nonnull responseObject) {
                if ([responseObject isEqualToString:@"0"]) {
                    WDStrongify(self);
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"取消成功") attachedView:self.view show:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                }
            } failure:nil];
        } else {
            // 购买
            [self.payViewModel yy_viewModelBuyCancelWithAddress:self.accountModel.address orderId:self.model.OrderID success:^(id  _Nonnull responseObject) {
                if ([responseObject isEqualToString:@"0"]) {
                    WDStrongify(self);
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"取消成功") attachedView:self.view show:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                }
            } failure:nil];
        }
    } else if (self.model.Status == 1 || self.model.Status == 2) {
        // status == 1， 2
        WDWeakify(self);
        if (self.model.direction == 1) {
            // 出售
            [self.sellViewModel yy_viewModelCancelBuyWithAddress:self.accountModel.address orderId:self.model.OrderID success:^(id  _Nonnull responseObject) {
                if ([responseObject isEqualToString:@"0"]) {
                    WDStrongify(self);
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"取消成功") attachedView:self.view show:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                }
            } failure:nil];
        } else {
            // 购买
            [self.payViewModel yy_viewModelUnConfirmBuyWithAddress:self.accountModel.address orderId:self.model.OrderID success:^(id  _Nonnull responseObject) {
                WDStrongify(self);
                [YYToastView showCenterWithTitle:YYStringWithKey(@"取消成功") attachedView:self.view show:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } failure:nil];
        }
    } else if (self.model.Status == 3) {
        [self confirmTrasnferactionWithStatus:0];
    }
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

@end
