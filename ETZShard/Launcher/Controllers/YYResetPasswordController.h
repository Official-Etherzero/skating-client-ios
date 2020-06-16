//
//  YYResetPasswordController.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "WDBaseFunctionController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYResetPasswordController : WDBaseFunctionController

- (instancetype)initResetPswViewControllerWithMobile:(NSString *)mobile;

- (instancetype)initResetPswViewControllerWithMail:(NSString *)mail;

@end

NS_ASSUME_NONNULL_END
