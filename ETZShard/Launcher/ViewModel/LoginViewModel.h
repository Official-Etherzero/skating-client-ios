//
//  LoginViewModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIMVVMKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

// 登录接口
- (NSURLSessionTask *)yy_viewModelLoginWithMachineCode:(NSString *)machineCode
                                                  area:(NSString *)area
                                                 email:(NSString *)email
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 登录安全监测
- (NSURLSessionTask *)yy_viewModelLoginSafetyVerificationEmail:(NSString *)email
                                                       success:(successBlock _Nullable)success
                                                       failure:(failureBlock _Nullable)failure;

// 校验账户信息并且返回绑定状态 （登录前）
- (NSURLSessionTask *)yy_viewModelLoginSafetyVerificationArea:(NSString *)area
                                                        email:(NSString *)email
                                                     password:(NSString *)password
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
