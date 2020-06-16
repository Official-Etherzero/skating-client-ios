//
//  PayDetailView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PayDetailView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "YYToastView.h"

@interface PayDetailView ()

@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, strong) YYLabel    *timeView;
@property (nonatomic, strong) NSTimer    *timer;

@end

@implementation PayDetailView

- (void)dealloc {
    [self destoryTimer];
}

- (instancetype)initWithOrderModel:(OrderModel *)model {
    if (self = [super init]) {
        self.model = model;
        self.senconds = 30;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_1a1a1a text:YYStringWithKey(@"等待卖方确认")];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        }];
        
        YYLabel *statusView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"状态")];
        statusView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:statusView];
        [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleView.mas_left);
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        self.timeView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_44 textColor:COLOR_ff5959 text:[NSString stringWithFormat:@"%lds",(long)self.senconds]];
        self.timeView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeView];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_42);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        }];
        
        // line1
        UIView *lineView1 = [UIView new];
        lineView1.backgroundColor = COLOR_edf0f5;
        [self addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(statusView.mas_bottom).offset(YYSIZE_18);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
        }];
        
        float total = self.model.UBI * self.model.Price;
        NSString *totalStr = [NSString stringWithFormat:@"%f",total];
        NSString *t = [NSString stringWithFormat:@"¥ %@",[totalStr yy_holdDecimalPlaceToIndex:4]];
        YYLabel *totalView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_3d5afe text:t];
        totalView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:totalView];
        [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(lineView1.mas_bottom).offset(YYSIZE_18);
        }];
        
        YYLabel *amountTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"交易金额")];
        amountTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:amountTitleView];
        [amountTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(totalView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *priceTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"单价")];
        priceTitleView.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceTitleView];
        [priceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView1.mas_bottom).offset(YYSIZE_22);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        }];
        
        YYLabel *priceView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:[NSString stringWithFormat:@"%f USDT",self.model.Price]];
        priceView.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceView];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView1.mas_bottom).offset(YYSIZE_22);
            make.right.mas_equalTo(priceTitleView.mas_left).offset(-YYSIZE_06);
        }];
        
        YYLabel *dataTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"数量")];
        dataTitleView.textAlignment = NSTextAlignmentRight;
        [self addSubview:dataTitleView];
        [dataTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(priceView.mas_bottom).offset(YYSIZE_06);
            make.right.mas_equalTo(priceTitleView.mas_right);
        }];
        
        YYLabel *dataView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:[NSString stringWithFormat:@"%f UBI",self.model.UBI]];
        dataView.textAlignment = NSTextAlignmentRight;
        [self addSubview:dataView];
        [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(priceView.mas_bottom).offset(YYSIZE_06);
            make.right.mas_equalTo(dataTitleView.mas_left).offset(-YYSIZE_06);
        }];
        
        // line2
        UIView *lineView2 = [UIView new];
        lineView2.backgroundColor = COLOR_edf0f5;
        [self addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(lineView1.mas_bottom).offset(YYSIZE_75);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
        }];
        
        // （买）卖家地址  支付方式  下单时间  订单号  卖家收款地址  付款 hash 值
        YYLabel *addressTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"卖家地址")];
        addressTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:addressTitleView];
        [addressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(lineView2.mas_bottom).offset(YYSIZE_18);
        }];
        
        YYLabel *addressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:self.model.UBIWallet];
        addressView.textAlignment = NSTextAlignmentRight;
        addressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:addressView];
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(addressTitleView.mas_top);
            make.width.mas_offset(YYSIZE_160);
        }];
        
        YYLabel *paymentTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"支付方式")];
        paymentTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:paymentTitleView];
        [paymentTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(addressTitleView.mas_bottom).offset(YYSIZE_16);
        }];
        
        YYLabel *paymentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:@"USDT"];
        paymentView.textAlignment = NSTextAlignmentRight;
        paymentView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:paymentView];
        [paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(paymentTitleView.mas_top);
            make.width.mas_offset(YYSIZE_182);
        }];
        
        YYLabel *orderTimeTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"下单时间")];
        orderTimeTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:orderTimeTitleView];
        [orderTimeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(paymentTitleView.mas_bottom).offset(YYSIZE_16);
        }];
        
        YYLabel *orderTimeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:self.model.WriteTime];
        orderTimeView.textAlignment = NSTextAlignmentRight;
        [self addSubview:orderTimeView];
        [orderTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(orderTimeTitleView.mas_top);
        }];
        
        YYLabel *orderNumberTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"订单号")];
        orderNumberTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:orderNumberTitleView];
        [orderNumberTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(orderTimeTitleView.mas_bottom).offset(YYSIZE_16);
        }];
        
        YYLabel *orderNumberView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:self.model.OrderID];
        orderNumberView.textAlignment = NSTextAlignmentRight;
        [self addSubview:orderNumberView];
        [orderNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(orderNumberTitleView.mas_top);
        }];
        
        YYLabel *usdtAddressTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"卖家收款地址")];
        usdtAddressTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:usdtAddressTitleView];
        [usdtAddressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(orderNumberTitleView.mas_bottom).offset(YYSIZE_16);
        }];
        
        YYButton *usdtCopyView = [YYButton buttonWithType:UIButtonTypeCustom];
        usdtCopyView.stretchLength = 10.0f;
        [usdtCopyView setImage:[UIImage imageNamed:@"copy_ubi"] forState:UIControlStateNormal];
        [self addSubview:usdtCopyView];
        [usdtCopyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(usdtAddressTitleView.mas_centerY);
        }];
        WDWeakify(self);
        [usdtCopyView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self copyWithAddress:self.model.USDTAddr];
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYLabel *usdtAddressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:self.model.USDTAddr];
        usdtAddressView.textAlignment = NSTextAlignmentRight;
        usdtAddressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:usdtAddressView];
        [usdtAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(usdtCopyView.mas_left).offset(-YYSIZE_03);
            make.top.mas_equalTo(usdtAddressTitleView.mas_top);
            make.width.mas_offset(YYSIZE_160);
        }];
        
        YYLabel *hashAddressTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"付款HASH")];
        hashAddressTitleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:hashAddressTitleView];
        [hashAddressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(usdtAddressTitleView.mas_bottom).offset(YYSIZE_16);
        }];
        
        YYButton *hashCopyView = [YYButton buttonWithType:UIButtonTypeCustom];
        hashCopyView.stretchLength = 10.0f;
        [hashCopyView setImage:[UIImage imageNamed:@"copy_ubi"] forState:UIControlStateNormal];
        [self addSubview:hashCopyView];
        [hashCopyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(hashAddressTitleView.mas_centerY);
        }];
        [hashCopyView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self copyWithAddress:self.model.Hash];
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYLabel *hashAddressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a text:self.model.Hash];
        hashAddressView.textAlignment = NSTextAlignmentRight;
        hashAddressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:hashAddressView];
        [hashAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(hashCopyView.mas_left).offset(-YYSIZE_03);
            make.top.mas_equalTo(hashAddressTitleView.mas_top);
            make.width.mas_offset(YYSIZE_160);
        }];
        
        // line3
        UIView *lineView3 = [UIView new];
        lineView3.backgroundColor = COLOR_edf0f5;
        [self addSubview:lineView3];
        [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(hashAddressTitleView.mas_bottom).offset(YYSIZE_18);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
        }];
    }
    return self;
}

- (void)setSenconds:(NSInteger)senconds {
    _senconds = senconds;
}

- (void)timeFireMethod {
    self.timeView.text = [NSString stringWithFormat:@"%lds",(long)self.senconds];
    self.senconds --;
    if(self.senconds == 0){
        [self destoryTimer];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }
}

- (void)destoryTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)copyWithAddress:(NSString *)address {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = address;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:[UIApplication sharedApplication].keyWindow];
}

@end
