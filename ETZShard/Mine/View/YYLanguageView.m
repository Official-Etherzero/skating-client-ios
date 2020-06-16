//
//  YYLanguageView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/7.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLanguageView.h"
#import "YYViewHeader.h"

@interface YYLanguageView ()

@property (nonatomic, strong) NSArray        *titles;
@property (nonatomic, strong) NSMutableArray <UIButton *> *taps;
@property (nonatomic, strong) MASConstraint  *sliderCenterXConstraint;
@property (nonatomic, strong) UIButton       *currentButton;

@end

@implementation YYLanguageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles font:(UIFont *)font selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor selectedbgColor:(UIColor *)selectedbgColor {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = COLOR_ffffff;
        if (titles.count == 0) {
            return self;
        }
        self.taps = @[].mutableCopy;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height / titles.count;
        for (int i = 0; i < _titles.count; ++i) {
            NSString *_t = _titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [tap addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
            tap.tag = i; //for index
            [tap setTitleColor:normalColor forState:UIControlStateNormal];
            [tap setTitleColor:selectedColor forState:UIControlStateSelected];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            tap.titleLabel.font = font;
            [tap setBackgroundImage:[UIImage yy_imageWithColor:COLOR_ffffff] forState:UIControlStateNormal];
            [tap setBackgroundImage:[UIImage yy_imageWithColor:selectedbgColor] forState:UIControlStateSelected];
            [self addSubview:tap];
            tap.frame = CGRectMake(0, i * height, width, height);
            [self.taps addObject:tap];
        }
    }
    return self;
}

- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}

- (void)tapDidClick:(UIButton *)tap {
    self.currentButton = tap;
    _index = tap.tag;
    [self.taps enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = tap == button;
    }];
}

- (void)setIndex:(NSInteger)index {
    if (self.taps.count < index) {
    } else {
        [self tapDidClick:self.taps[index]];
    }
}

@end
