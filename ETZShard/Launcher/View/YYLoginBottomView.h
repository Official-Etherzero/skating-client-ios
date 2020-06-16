//
//  YYLoginBottomView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYLoginBottomViewDelegate <NSObject>

- (void)yy_showRegisterLoginView;

@end

@interface YYLoginBottomView : UIView

@property (nonatomic,  weak) id<YYLoginBottomViewDelegate>delegate;

- (instancetype)initWithTitle:(NSString *)title des:(NSString *)des;

@end

NS_ASSUME_NONNULL_END
