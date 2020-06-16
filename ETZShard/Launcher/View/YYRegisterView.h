//
//  YYRegisterView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/23.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYRegisterViewDelegate <NSObject>
@optional;
// 隐藏显示注册登录视图
- (void)yy_showLoginViewHidenRegisterView;
// 发验短信证码
- (void)yy_sendMobileVerificationCodeWithMobile:(NSString *)mobile
                                           area:(NSString *)area;
// 发邮件验证码
- (void)yy_sendEmailVerificationCodeWithEmail:(NSString *)email;
// push 隐私 VC
- (void)yy_enterPrivacyController;
// push 地区 VC
- (void)yy_enterRegionController;
// 注册 && 手机注册 邮箱注册
- (void)yy_registeAccountMobile:(NSString *)mobile
                           area:(NSString *)area
                       password:(NSString *)password
                          vcode:(NSString *)vcode
                         incode:(NSString *)incode;
// 邮箱注册
- (void)yy_registeAccountEmail:(NSString *)email
                      password:(NSString *)password
                         vcode:(NSString *)vcode
                        incode:(NSString *)incode;

@end

typedef NS_ENUM(NSUInteger, YYRegisterType) {
    YYRegisterTypePhone = 0,  // 手机号注册
    YYRegisterTypeEmail = 1,  // 手机号登录
};

@interface YYRegisterView : UIView

@property (nonatomic, assign) YYRegisterType type;
@property (nonatomic,   weak) id<YYRegisterViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
