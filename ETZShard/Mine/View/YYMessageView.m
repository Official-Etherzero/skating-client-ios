//
//  YYMessageView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYMessageView.h"
#import "YYViewHeader.h"
#import "UILabel+Ext.h"
#import <pop/pop.h>
#import "MSSPopMasonry.h"
#import "YYCodeView.h"
#import "YYInterfaceMacro.h"
#import "CodeModel.h"
#import "YYGCDTimer.h"

@interface YYMessageView ()

@property (nonatomic, strong) NSMutableArray *codeViews;
@property (nonatomic, strong) YYButton       *confrimView;
@property (nonatomic, strong) YYLabel        *timeView;
@property (nonatomic,   copy) NSString          *gcdTimer;
@property (nonatomic, assign) NSInteger         currentCount;

@end

@implementation YYMessageView

- (instancetype)initMessageViewWithModelist:(NSArray *)list {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        // 只需要传一个数组的接口来使用
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_090814 text:YYStringWithKey(@"安全验证")];
        [titleView yy_setWordSpace:0];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_80, YYSIZE_15));
        }];
        
        YYButton *rightView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 title:YYStringWithKey(@"取消") titleColor:COLOR_090814_A05];
        [rightView.titleLabel yy_setWordSpace:0];
        rightView.stretchLength = 10.0f;
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleView.mas_centerY);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_25);
            make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_13));
        }];
        [rightView addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];;
        
        // YYCodeView
        YYCodeView *lastView = nil;
        WDWeakify(self);
        for (int i = 0; i < list.count; i ++) {
//            NSString *_t = yyGetValidateCodeString([list[i] integerValue]);
//            YYCodeView *codeView = [[YYCodeView alloc] initCodeViewWithTitle:YYStringWithKey(_t) mode:[list[i] integerValue]];
//            codeView.tag = [list[i] integerValue];
//            codeView.codeBlock = ^(NSInteger code) {
//                WDStrongify(self);
//                if (self.sendCodeBlock) {
//                    self.sendCodeBlock(code);
//                }
//            };
//            [self addSubview:codeView];
//            [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (lastView) {
//                    make.top.mas_equalTo(lastView.mas_bottom);
//                } else {
//                    make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_10);
//                }
//                make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_74));
//            }];
//            lastView = codeView;
//            [self.codeViews addObject:codeView];
        }
        YYButton *confrimView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_7a6cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确定") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
        [self addSubview:confrimView];
        [confrimView yy_setGradientColors:@[(__bridge id)COLOR_ffca46.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
        [confrimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
        }];
        [confrimView addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        self.confrimView = confrimView;
    }
    return self;
}

- (void)confirmClick {
    NSMutableArray *arr = [NSMutableArray array];
    for (YYCodeView *codeView in self.codeViews) {
        [arr addObject:codeView.plcView.content];
    }
    if (self.messageBlock) {
        self.messageBlock(arr);
    }
}

- (void)cancelClick {
    if (self.hideBlock) {
        self.hideBlock();
    }
}

#pragma mark - lazy

- (NSMutableArray *)codeViews {
    if (!_codeViews) {
        _codeViews = [NSMutableArray array];
    }
    return _codeViews;
}

@end
