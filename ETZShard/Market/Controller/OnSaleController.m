//
//  OnSaleController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "OnSaleController.h"
#import "YYPlaceholderView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "YYToastView.h"
#import <BlocksKit/BlocksKit.h>
#import "WalletDataManager.h"
#import "YYInterfaceMacro.h"
#import "YYSellViewModel.h"
#import "SettingPasswordView.h"
#import "OtcDetailModel.h"
#import "NSString+Ext.h"
#import "SettingAddressView.h"

@interface OnSaleController ()

@property (nonatomic, strong) YYPlaceholderView *averagePriceView;
@property (nonatomic, strong) YYPlaceholderView *priceView;
@property (nonatomic, strong) YYPlaceholderView *dataView;
@property (nonatomic, strong) YYPlaceholderView *totalView;
@property (nonatomic, strong) YYLabel           *totalPriceView;
@property (nonatomic, strong) YYPlaceholderView *addressView;
@property (nonatomic, strong) YYLabel           *collectionAddressView;
@property (nonatomic,   copy) NSString          *address;
@property (nonatomic, strong) YYSellViewModel   *sellViewModel;
@property (nonatomic, strong) OtcDetailModel    *model;

@end

@implementation OnSaleController

- (void)dealloc {
    [self.dataView removeObserver:self forKeyPath:@"content"];
    [self.priceView removeObserver:self forKeyPath:@"content"];
}

- (instancetype)initOnSaleViewControllerWithAddress:(NSString *)address {
    if (self = [super init]) {
        self.address = address;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"挂卖单");
    [self initSubViews];
    [self initViewModel];
}

- (void)initSubViews {
    self.averagePriceView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"当前平均价格：0.75 USDT") plcStr:@""];
    [self.averagePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_58));
    }];
    self.averagePriceView.userInteractionEnabled = NO;
    
    self.priceView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"单价") plcStr:YYStringWithKey(@"价格勿超过平均价正负10%")];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.averagePriceView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_58));
    }];
    
    self.dataView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"数量") plcStr:YYStringWithKey(@"请输入数量")];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_58));
    }];
    
    YYLabel *ubiView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_28 textColor:COLOR_1a1a1a text:@"UBI"];
    ubiView.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:ubiView];
    [ubiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(self.dataView.mas_centerY);
    }];
    
    self.totalView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"总价") plcStr:@""];
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_58));
    }];
    self.totalView.userInteractionEnabled = NO;
    
    self.totalPriceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ff5959 text:YYStringWithKey(@"0 USDT")];
    self.totalPriceView.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.totalPriceView];
    [self.totalPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(self.totalView.mas_centerY);
        make.width.mas_offset(YYSIZE_240);
    }];
    
    self.addressView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"收款地址") plcStr:@""];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_58));
    }];
    self.addressView.userInteractionEnabled = NO;
    
    NSString *address = [WalletDataManager accountModel].address;
    self.collectionAddressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:address];
    self.collectionAddressView.textAlignment = NSTextAlignmentRight;
    self.collectionAddressView.numberOfLines = 0;
    [self.view addSubview:self.collectionAddressView];
    [self.collectionAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(self.addressView.mas_centerY);
        make.width.mas_offset(YYSIZE_200);
    }];
    
    YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    cancelView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cancelView];
    [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressView.mas_bottom).offset(YYSIZE_40);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    WDWeakify(self);
    [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认挂售") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
    confirmView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:confirmView];
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressView.mas_bottom).offset(YYSIZE_40);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_150, YYSIZE_45));
    }];
    [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self confirmOnSaleConditions];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.dataView addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:nil];
    [self.priceView addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.sellViewModel yy_viewModelGetInfoWithAddress:self.address success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[OtcDetailModel class]]) {
            WDStrongify(self);
            self.model = responseObject;
            NSString *price = [[NSString stringWithFormat:@"%f",self.model.Price] yy_holdDecimalPlaceToIndex:4];
            self.averagePriceView.title = [NSString stringWithFormat:@"%@%@ USDT",YYStringWithKey(@"当前平均价格:"),price];
            self.collectionAddressView.text = self.model.USDTReceAddr;
        }
    } failure:nil];
}

- (void)confirmOnSaleConditions {
    if (!(self.priceView.content && self.priceView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入单价") attachedView:self.view];
        return;
    }
    if (!(self.dataView.content && self.dataView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入出售 UBI 的数量") attachedView:self.view];
        return;
    }
    if (self.model.USDTReceAddr.length < 1) {
        // 设置 USDT 地址
        WDWeakify(self);
        [SettingAddressView showSettingAddressViewBlock:^(NSString * _Nonnull address) {
            WDStrongify(self);
            [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
                [self.sellViewModel yy_viewModelSetUsdtAddressWithAddress:self.address password:psd usdtAddress:address success:^(id  _Nonnull responseObject) {
                    if ([responseObject isEqualToString:@"0"]) {
                        // 设置成功
                        [YYToastView showCenterWithTitle:YYStringWithKey(@"设置 USDT 地址成功") attachedView:self.view show:^{
                            [self confirmOnSale];
                        }];
                        self.collectionAddressView.text = address;
                    } else {
                        [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
                    }
                } failure:nil];
            } cancelBlock:nil];
        } cancelBlock:nil];
    } else {
        [self confirmOnSale];
    }
}

- (void)confirmOnSale {
    if (!(self.priceView.content && self.priceView.content.length > 1)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入单价") attachedView:self.view];
        return;
    }
    if (!(self.dataView.content && self.dataView.content.length > 1)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入出售 UBI 的数量") attachedView:self.view];
        return;
    }
    WDWeakify(self);
    [SettingPasswordView showSettingPasswordViewBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.sellViewModel yy_viewModelCreateSaleWithAddress:self.address password:psd count:[self.dataView.content floatValue] price:[self.priceView.content floatValue] success:^(id  _Nonnull responseObject) {
            if ([responseObject isEqualToString:@"0"]) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"挂卖单成功") attachedView:self.view show:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                [YYToastView showCenterWithTitle:responseObject attachedView:self.view];
            }
        } failure:nil];
    } cancelBlock:nil];
}

#pragma mark - kvo

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([object isEqual:self.priceView]) {
        self.priceView = object;
        double data = [self.dataView.content doubleValue];
        double total = data * [self.priceView.content doubleValue];
        NSString *dataStr = [[NSString stringWithFormat:@"%f",total] yy_holdDecimalPlaceToIndex:4];
        self.totalPriceView.text = [NSString stringWithFormat:@"%@ USDT",dataStr];
    }
    if ([object isEqual:self.dataView]) {
        self.dataView = object;
        double data = [self.dataView.content doubleValue];
        double total = data * [self.priceView.content doubleValue];
        NSString *dataStr = [[NSString stringWithFormat:@"%f",total] yy_holdDecimalPlaceToIndex:4];
        self.totalPriceView.text = [NSString stringWithFormat:@"%@ USDT",dataStr];
    }
}

#pragma mark - lazy

- (YYSellViewModel *)sellViewModel {
    if (!_sellViewModel) {
        _sellViewModel = [[YYSellViewModel alloc] init];
    }
    return _sellViewModel;
}

@end
