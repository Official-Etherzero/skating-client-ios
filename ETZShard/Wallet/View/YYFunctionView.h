//
//  YYFunctionView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYFunctionViewDelegate <NSObject>

- (void)yy_functionClickWithCurrentIndex:(NSUInteger)index;

@end

@interface YYFunctionView : UIView

@property (nonatomic,   weak)id<YYFunctionViewDelegate>delegate;

- (instancetype)initWithImages:(NSArray *)images titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
