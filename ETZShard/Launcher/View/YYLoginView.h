//
//  YYLoginView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/23.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYLoginViewDelegate <NSObject>

@optional;
- (void)yy_showRegisterViewHiddenLoginView;
- (void)yy_loginViewEnterRegionController;
- (void)yy_loginViewEnterForgetController;

- (void)yy_loginViewLoginByPhoneWithArea:(NSString *)area
                                  mobile:(NSString *)mobile
                                password:(NSString *)password;

- (void)yy_loginViewLoginByMailWithMail:(NSString *)mail
                               password:(NSString *)password;

@end

typedef NS_ENUM(NSUInteger, YYLoginType) {
    YYLoginTypePhone = 0,  // 手机号注册
    YYLoginTypeEmail = 1,  // 手机号登录
};

@interface YYLoginView : UIView

@property (nonatomic, assign) YYLoginType type;
@property (nonatomic,   weak) id<YYLoginViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
