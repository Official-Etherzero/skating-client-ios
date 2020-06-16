//
//  AccountsView.m
//  UBIClientForiOS
//
//  Created by etz on 2020/1/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "AccountsView.h"
#import "YYViewHeader.h"

@interface AccountsView ()

@property (nonatomic,   copy) TapAccountBlock accountBlock;
@property (nonatomic, strong) NSMutableArray<UIButton *> *taps;

@end

@implementation AccountsView

- (instancetype)initViewTapsBlock:(TapAccountBlock)accountBlock selectedIndex:(NSInteger)selectedIndex {
    if (self = [super init]) {
        self.currentIndex = selectedIndex;
        self.backgroundColor = COLOR_ffffff;
        self.accountBlock = accountBlock;
        NSArray *_titles = @[@"交易账户",@"机器人账户",@"钱包账户"];
        self.taps = @[].mutableCopy;
        UIButton *lastView = nil;
        for (int i = 0; i < _titles.count; ++i) {
            NSString *_t = _titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchDown];
            tap.tag = i; //for index Synchronous enumerated value
            [tap setTitleColor:COLOR_1a1a1a forState:UIControlStateNormal];
            [tap setTitleColor:COLOR_3d5afe forState:UIControlStateSelected];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            tap.titleLabel.font = FONT_DESIGN_30; //FONT_PingFangSC_Heavy_30
            [self addSubview:tap];
            [self.taps addObject:tap];
            [tap mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(YYSIZE_12);
                } else {
                    make.top.mas_equalTo(self.mas_top).offset(YYSIZE_10);
                }
                make.centerX.mas_equalTo(self.mas_centerX);
                make.height.mas_offset(YYSIZE_17);
            }];
            lastView = tap;
            if (i == selectedIndex) {
                tap.selected = YES;
            }
        }
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (self.taps.count < currentIndex) {
    } else {
        [self tapDidClick:self.taps[currentIndex]];
    }
}

- (void)tapDidClick:(UIButton *)tap {
    _currentIndex = tap.tag;
    [self.taps enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = tap == button;
    }];
    if (self.accountBlock) {
        self.accountBlock(tap.tag);
    }
}

@end
