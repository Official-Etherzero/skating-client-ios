//
//  SecurityModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2020/1/14.
//  Copyright © 2020 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecurityModel : NSObject

@property (nonatomic,   copy) NSString *title;         // 标题
@property (nonatomic,   copy) NSString *statusString;  // 状态描述
@property (nonatomic,   copy) UIColor  *desColor;      // 描述字体颜色

+ (instancetype)modelWithTitle:(NSString *)title des:(NSString *)des color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
