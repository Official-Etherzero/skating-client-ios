//
//  WDBuyCoinController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBuyCoinController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"
#import "NSString+Ext.h"
#import "SettingPasswordView.h"
#import "YYPayViewModel.h"
#import "WalletDataManager.h"
#import "OrderDetailModel.h"
#import "PayUsdtView.h"
#import "NSString+Ext.h"
#import "YYTextView.h"
#import "PayDetailView.h"

@interface WDBuyCoinController ()
<UITextViewDelegate>

@property (nonatomic, strong) OrderModel       *model;
@property (nonatomic, strong) YYPayViewModel   *viewModel;
@property (nonatomic, strong) OrderDetailModel *detailModel;
@property (nonatomic, strong) AccountModel     *accountModel;
@property (nonatomic, strong) YYTextView       *textView;
@property (nonatomic, strong) YYButton         *cancelTransferView;
@property (nonatomic, strong) YYButton         *confirmPayView;
@property (nonatomic, strong) YYButton         *cancelView;
@property (nonatomic, strong) YYButton         *confrimView;
@property (nonatomic, strong) YYButton         *statusTitleView;
@property (nonatomic,   copy) NSString         *hashString;
@property (nonatomic, strong) PayDetailView    *detailView;

@end

@implementation WDBuyCoinController

- (instancetype)initViewControllerWithOrderModel:(OrderModel *)model detail:(OrderDetailModel *)detail {
    if (self = [super init]) {
        self.model = model;
        self.detailModel = detail;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"Buy");
    self.view.backgroundColor = COLOR_ffffff;
    self.accountModel = [WalletDataManager accountModel];
    [self initSubViews];
}

- (void)initSubViews {
    self.detailView = [[PayDetailView alloc] initWithOrderModel:self.model];
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
    
    self.cancelView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消购买") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.cancelView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cancelView];
    [self.cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_30);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [self.cancelView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.viewModel yy_viewModelBuyCancelWithAddress:self.accountModel.address orderId:self.detailModel.OrderID success:^(id  _Nonnull responseObject) {
        } failure:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.confrimView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认购买") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
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
    
    self.textView = [YYTextView new];
    self.textView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
    self.textView.placeholder = YYStringWithKey(@"请输入交易HASH");
    self.textView.placeholderColor= COLOR_1a1a1a_A03;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 5.0;
    self.textView.textAlignment = NSTextAlignmentCenter;
    [self.textView setFont:FONT_DESIGN_24];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_332, YYSIZE_36));
    }];
    self.textView.hidden = YES;
    
    self.cancelTransferView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消交易") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    self.cancelTransferView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cancelTransferView];
    [self.cancelTransferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(YYSIZE_20);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [self.cancelTransferView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.viewModel yy_viewModelUnConfirmBuyWithAddress:self.accountModel.address orderId:self.detailModel.OrderID success:^(id  _Nonnull responseObject) {
        } failure:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    self.cancelTransferView.hidden = YES;
    
    self.confirmPayView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"已支付") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
    self.confirmPayView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.confirmPayView];
    [self.confirmPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelTransferView.mas_top);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [self.confirmPayView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.viewModel yy_viewModelSetHashWithAddress:self.accountModel.address orderId:self.detailModel.OrderID hash:self.hashString success:^(id  _Nonnull responseObject) {
            if ([responseObject isEqualToString:@"0"]) {
                [self showHaveToPalyView];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
            
        } failure:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    self.confirmPayView.hidden = YES;
    
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

- (void)showConfirmPayView {
    self.cancelView.hidden = self.confrimView.hidden = YES;
    self.textView.hidden = self.cancelTransferView.hidden = self.confirmPayView.hidden = NO;
}

- (void)showHaveToPalyView {
    self.textView.hidden = self.cancelTransferView.hidden = self.confirmPayView.hidden = YES;
    self.statusTitleView.hidden = NO;
}

- (void)showSettingPasswordView {
    WDWeakify(self);
    [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.viewModel yy_viewModelSureWantToBuyWithAddress:self.accountModel.address password:psd orderId:self.detailModel.OrderID usdtAddress:self.detailModel.USDTAddr success:^(id  _Nonnull responseObject) {
            if ([responseObject isEqualToString:@"0"]) {
                // 成功
                [self showPayUsdtView];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
    } cancelBlock:nil];
}

- (void)showPayUsdtView {
    float amount = self.model.UBI * self.model.Price;
    NSString *amountStr = [[NSString stringWithFormat:@"%f",amount] yy_holdDecimalPlaceToIndex:4];
    WDWeakify(self);
    [PayUsdtView showPayUsdtViewWithAddress:self.detailModel.USDTAddr amount:amountStr confirmBlock:^(NSString * _Nonnull address) {
        WDStrongify(self);
        [self copyWithAddress:address];
    } cancelBlock:nil];
}

- (void)copyWithAddress:(NSString *)address {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = address;
    WDWeakify(self);
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view show:^{
        WDStrongify(self);
        [self showConfirmPayView];
    }];
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.hashString = textView.text;
}

#pragma mark - lazy

- (YYPayViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYPayViewModel alloc] init];
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
