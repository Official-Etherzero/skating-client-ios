//
//  YYChargeView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYChargeView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYTextView.h"
#import "YYInterfaceMacro.h"

@interface YYChargeView ()

@property (nonatomic, strong) YYTextView         *chargeView;
@property (nonatomic,   copy) ChargeConfirmBlock confirmBlock;
@property (nonatomic,   copy) ChargeCancelBlock  cancelBlock;

@end

@implementation YYChargeView

+ (instancetype)showChargeViewBlock:(ChargeConfirmBlock)block cancelBlock:(ChargeCancelBlock _Nullable)cancelBlock {
    YYChargeView *view = [[YYChargeView alloc] init];
    view.confirmBlock = block;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_ffffff;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_210);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_175));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_1a1a1a text:YYStringWithKey(@"充值")];
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_18);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        YYTextView *dataView = [YYTextView new];
        dataView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        [bottomView addSubview:dataView];
        dataView.layer.borderWidth = 0.5;
        dataView.layer.cornerRadius = 2.0;
        dataView.textAlignment = NSTextAlignmentLeft;
        dataView.font = FONT_DESIGN_24;
        dataView.placeholder = YYStringWithKey(@"数量");
        dataView.placeholderColor = COLOR_1a1a1a_A03;
        dataView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_18);
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_170, YYSIZE_31));
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_22 textColor:COLOR_1a1a1a text:@"ETZ"];
        [bottomView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(dataView.mas_centerY);
            make.left.mas_equalTo(dataView.mas_right).offset(YYSIZE_06);
        }];
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.top.mas_equalTo(dataView.mas_bottom).offset(YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        WDWeakify(self);
        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:2.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_36);
            make.top.mas_equalTo(cancelView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (dataView.text.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入充值金额") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (self.confirmBlock) {
                self.confirmBlock(dataView.text);
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
