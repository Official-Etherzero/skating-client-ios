//
//  MarketMiddleView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "MarketMiddleView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface MarketMiddleView ()

@property (nonatomic, strong) YYLabel  *contentView;
@property (nonatomic, strong) YYButton *buyButton;
@property (nonatomic, strong) YYButton *sellButtoon;
@property (nonatomic, strong) YYButton *seeView;

@end

@implementation MarketMiddleView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_3d5afe_A005;
        self.contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a text:YYStringWithKey(@"暂无订单")];
        self.contentView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(YYSIZE_240);
        }];
        
        self.sellButtoon = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"挂卖") titleColor:COLOR_3d5afe];
        self.sellButtoon.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.sellButtoon];
        [self.sellButtoon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        WDWeakify(self);
        [self.sellButtoon bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if ([self.delegate respondsToSelector:@selector(yy_selectedSellOrderView)]) {
                [self.delegate yy_selectedSellOrderView];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.buyButton = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"挂买") titleColor:COLOR_3d5afe];
        self.buyButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.buyButton];
        [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.sellButtoon.mas_left).offset(-YYSIZE_18);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.buyButton bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if ([self.delegate respondsToSelector:@selector(yy_selectedPayOrderView)]) {
                [self.delegate yy_selectedPayOrderView];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.seeView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"立即查看") titleColor:COLOR_3d5afe];
        self.seeView.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.seeView];
        self.seeView.hidden = YES;
        [self.seeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.seeView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if ([self.delegate respondsToSelector:@selector(yy_selectedOrderDetailView)]) {
                [self.delegate yy_selectedOrderDetailView];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)outstandingOrders:(BOOL)isHave {
    if (isHave) {
        self.contentView.text = YYStringWithKey(@"您有一笔未完成的订单");
        self.seeView.hidden = NO;
        self.sellButtoon.hidden = YES;
        self.buyButton.hidden = YES;
    } else {
        self.contentView.text = YYStringWithKey(@"暂无订单");
        self.seeView.hidden = YES;
        self.sellButtoon.hidden = NO;
        self.buyButton.hidden = NO;
    }
}


@end
