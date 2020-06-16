//
//  YYScrollView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/25.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYScrollView.h"

@implementation YYScrollView

- (instancetype)initDefalutScrollView {
    if (self = [super init]) {
        self.bounces = YES;
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (@available(iOS 11.0, *)) {
            if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return true;
}


@end
