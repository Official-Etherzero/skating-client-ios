//
//  YYButton.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/22.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYButton : UIButton

@property(nonatomic, assign) CGFloat leftArea;
@property(nonatomic, assign) CGFloat rightArea;
@property(nonatomic, assign) CGFloat topArea;
@property(nonatomic, assign) CGFloat bottomArea;

// 点击区域
@property(nonatomic, assign) CGRect  hiteFrame;

@property(nonatomic, assign) CGFloat stretchLength;

- (instancetype)initWithFont:(UIFont *)font borderWidth:(float)width borderColoer:(CGColorRef)cgclolor masksToBounds:(BOOL)isBounds title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(float)cornerRadius;

- (instancetype)initWithFont:(UIFont *)font
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor;


@end

NS_ASSUME_NONNULL_END
