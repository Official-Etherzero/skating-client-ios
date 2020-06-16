//
//  YYTouchView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/26.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYTouchView.h"
#import "YYViewHeader.h"
#import "UIView+Ext.h"

@interface YYTouchView ()

@property (nonatomic, strong) NSMutableArray <UIButton *> *taps;

@end

@implementation YYTouchView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_ffffff;
        if (titles.count == 0) {
            return self;
        }
        self.index = 0;
        self.taps = @[].mutableCopy;
        UIButton *lastView = nil;
        for (int i = 0; i < titles.count; ++i) {
            NSString *_t = titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchDown];
            tap.tag = i; //for index
            [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            [self addSubview:tap];
            [tap.titleLabel setFont:FONT_PingFangSC_Medium_30];
            [tap mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(YYSIZE_16);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
                }
                make.bottom.mas_equalTo(self.mas_bottom);
            }];
            lastView = tap;
            [tap setTitleColor:COLOR_090814_A05 forState:UIControlStateNormal];
            [tap setTitleColor:COLOR_090814 forState:UIControlStateSelected];
            if (i == 0) {
                tap.selected = YES;
                [tap.titleLabel setFont:FONT_PingFangSC_Medium_48];
            } else {
                [tap.titleLabel setFont:FONT_PingFangSC_Medium_30];
            }
            [self.taps addObject:tap];
        }
    }
    return self;
}

- (void)tapDidClick:(UIButton *)btn {
    self.index = btn.tag;
    [self.taps enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = btn == button;
        if (button.selected) {
            [button.titleLabel setFont:FONT_PingFangSC_Medium_48];
        } else {
            [button.titleLabel setFont:FONT_PingFangSC_Medium_30];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(yy_touchViewDidChangeIndex:)]) {
        [self.delegate yy_touchViewDidChangeIndex:self];
    }
}



@end
