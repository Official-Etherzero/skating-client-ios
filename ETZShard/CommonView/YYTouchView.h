//
//  YYTouchView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/26.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYTouchView;
NS_ASSUME_NONNULL_BEGIN

@protocol YYTouchViewDelegate <NSObject>

- (void)yy_touchViewDidChangeIndex:(YYTouchView *)touchView;

@end

@interface YYTouchView : UIView

@property(nonatomic,   weak) id <YYTouchViewDelegate> delegate;
@property(nonatomic, assign) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
