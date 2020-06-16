//
//  YYLanguageView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/7.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYLanguageView;

@protocol YYLanguageViewDelegate<NSObject>
- (void)yyLanguageViewDidChangeIndex:(YYLanguageView *)pageView;

@end

@interface YYLanguageView : UIView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic,   weak) id<YYLanguageViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles font:(UIFont *)font selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor selectedbgColor:(UIColor *)selectedbgColor;

@end

NS_ASSUME_NONNULL_END
