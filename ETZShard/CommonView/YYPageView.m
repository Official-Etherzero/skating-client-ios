//
//  YYPageView.m
//  Video_edit
//
//  Created by yang on 2018/11/1.
//  Copyright © 2018 m-h. All rights reserved.
//

#import "YYPageView.h"
#import "YYViewHeader.h"
#import "YYSize.h"
#import "YYColor.h"
#import "UIView+Ext.h"
#import <pop/pop.h>
#import "YYFont.h"
#import "UIButton+Ext.h"

@interface YYPageView ()
@property (nonatomic, strong) NSArray        *titles;
@property (nonatomic, strong) UIImageView    *sliderView;
@property (nonatomic, strong) NSMutableArray <UIButton *> *taps;
@property (nonatomic, strong) MASConstraint  *sliderCenterXConstraint;
@property (nonatomic, strong) NSArray        *images;
@property (nonatomic, strong) UIButton       *currentButton;

@end

@implementation YYPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = COLOR_ffffff;
        if (titles.count == 0) {
            return self;
        }
        self.taps = @[].mutableCopy;
        CGFloat width = frame.size.width / titles.count;
        
        for (int i = 0; i < _titles.count; ++i) {
            NSString *_t = _titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchDown];
            tap.tag = i; //for index
            [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            tap.titleLabel.font = FONT_PingFangSC_BLOD_32;
            [self addSubview:tap];
            tap.frame = CGRectMake(i * width, 0, width, frame.size.height);
            [tap setTitleColor:COLOR_1a1a1a_A05 forState:UIControlStateNormal];
            [tap setTitleColor:COLOR_3d5afe forState:UIControlStateSelected];
            if (i == 0) {
                tap.selected = YES;
                [tap yy_leftButtonAndImageWithSpacing:0];
            }
            [self.taps addObject:tap];
        }
        
        if (!self.sliderView) {
            self.sliderView = [[UIImageView alloc] initWithImage:[UIImage yy_imageWithColor:COLOR_3d5afe]];
            
            [self addSubview:self.sliderView];
            self.sliderView.autoresizesSubviews = NO;
            CGFloat sliderWidth = YYSIZE_48;
            CGFloat sliderHeight = YYSIZE_03;
            CGFloat sliderX = 0;
            CGFloat sliderY = frame.size.height - 3.0f;
            self.sliderView.frame = CGRectMake(sliderX, sliderY, sliderWidth, sliderHeight);
            UIButton *tapBtn = self.taps[_index];
            self.sliderView.yy_centerX = tapBtn.yy_centerX;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles font:(UIFont *)font selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor sliderColor:(UIColor *)sliderColor space:(CGFloat)space left:(CGFloat)left {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = COLOR_ffffff;
        if (titles.count == 0) {
            return self;
        }
        self.taps = @[].mutableCopy;
//        CGFloat width = frame.size.width / titles.count;
        
        UIButton *lastView = nil;
        for (int i = 0; i < _titles.count; ++i) {
            NSString *_t = _titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchDown];
            tap.tag = i; //for index
            [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            tap.titleLabel.font = font;
            [self addSubview:tap];
            [tap mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(space);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset(left);
                }
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
//            tap.frame = CGRectMake(i * width, 0, width, frame.size.height);
            [tap setTitleColor:normalColor forState:UIControlStateNormal];
            [tap setTitleColor:selectedColor forState:UIControlStateSelected];
            if (i == 0) {
                tap.selected = YES;
                [tap yy_leftButtonAndImageWithSpacing:0];
            }
            [self.taps addObject:tap];
            lastView = tap;
        }
        
        if (!self.sliderView) {
            self.sliderView = [[UIImageView alloc] initWithImage:[UIImage yy_imageWithColor:sliderColor]];
            
            [self addSubview:self.sliderView];
            self.sliderView.autoresizesSubviews = NO;
            CGFloat sliderWidth = YYSIZE_40;
            CGFloat sliderHeight = YYSIZE_03;
            CGFloat sliderX = 0;
            CGFloat sliderY = frame.size.height - 1.5;
            self.sliderView.frame = CGRectMake(sliderX, sliderY, sliderWidth, sliderHeight);
            UIButton *tapBtn = self.taps[_index];
            self.sliderView.yy_centerX = tapBtn.yy_centerX;
            [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_03);
                make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_03));
                make.centerX.mas_equalTo(tapBtn.mas_centerX);
            }];
        }
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles font:(UIFont *)font selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor sliderColor:(UIColor *)sliderColor {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = COLOR_ffffff;
        if (titles.count == 0) {
            return self;
        }
        self.taps = @[].mutableCopy;
        CGFloat width = frame.size.width / titles.count;
        
        for (int i = 0; i < _titles.count; ++i) {
            NSString *_t = _titles[i];
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            [tap addTarget:self action:@selector(tapDidClick:) forControlEvents:UIControlEventTouchDown];
            tap.tag = i; //for index
            [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tap setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            tap.titleLabel.font = font;
            [self addSubview:tap];
            tap.frame = CGRectMake(i * width, 0, width, frame.size.height);
            [tap setTitleColor:normalColor forState:UIControlStateNormal];
            [tap setTitleColor:selectedColor forState:UIControlStateSelected];
            if (i == 0) {
                tap.selected = YES;
                [tap yy_leftButtonAndImageWithSpacing:0];
            }
            [self.taps addObject:tap];
        }
        
        if (!self.sliderView) {
            self.sliderView = [[UIImageView alloc] initWithImage:[UIImage yy_imageWithColor:sliderColor]];
            
            [self addSubview:self.sliderView];
            self.sliderView.autoresizesSubviews = NO;
            CGFloat sliderWidth = YYSIZE_40;
            CGFloat sliderHeight = 3.0f;
            CGFloat sliderX = 0;
            CGFloat sliderY = frame.size.height - 3.0f;
            self.sliderView.frame = CGRectMake(sliderX, sliderY, sliderWidth, sliderHeight);
            UIButton *tapBtn = self.taps[_index];
            self.sliderView.yy_centerX = tapBtn.yy_centerX;
        }
    }
    return self;
}


- (void)setRedViewHidden {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]] &&
            subView.tag == self.index) {
            subView.hidden = YES;
        }
    }
}

- (void)setRedViewHiddenStatusWithIndex:(NSInteger)index isHidden:(BOOL)isHidden {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]] &&
            subView.tag == index) {
            subView.hidden = isHidden;
        }
    }
}

- (void)setSliderHiddenStatus:(BOOL)isHidden {
    self.sliderView.hidden = isHidden;
    self.currentButton.selected = !isHidden;
}

#pragma mark - method

- (void)tapDidClick:(UIButton *)tap {
    self.currentButton = tap;
    _index = tap.tag;
    [self.taps enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = tap == button;
    }];
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.taps[_index].yy_centerX, self.sliderView.yy_centerY)];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    [self.sliderView pop_addAnimation:animation forKey:@"centerXOffset"];
    if ([self.delegate respondsToSelector:@selector(pageViewDidChangeIndex:)]) {
        [self.delegate pageViewDidChangeIndex:self];
    }
}

- (void)setIndex:(NSInteger)index {
    if (self.taps.count < index) {
    } else {
        [self tapDidClick:self.taps[index]];
    }
}

@end
