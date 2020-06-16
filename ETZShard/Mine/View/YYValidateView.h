//
//  YYValidateView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/27.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYValidateView : UIView

+ (instancetype)initAttachView:(UIView *)view
                        titles:(NSArray *)titles
                   googleBlock:(void(^)(void))googleBlock
                    phoneBlock:(void(^)(void))phoneBlock;

@end

NS_ASSUME_NONNULL_END
