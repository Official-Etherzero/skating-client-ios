//
//  RegisterViewModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIMVVMKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewModel : NSObject<SMKViewModelProtocol>

// 多个接口支持外部传参
@property (nonatomic, strong) NSDictionary *parameters;

// 手机号注册 invite_code 非必选
- (NSURLSessionTask *)yy_viewModelRegisterWithMachineCode:(NSString *)machineCode
                                                   mobile:(NSString *)mobile
                                                     area:(NSString *)area
                                                 password:(NSString *)password
                                              mobile_code:(NSString *)mobile_code
                                              invite_code:(NSString *)invite_code
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 邮箱注册
- (NSURLSessionTask *)yy_viewModelRegisterWithMachineCode:(NSString *)machineCode
                                                    email:(NSString *)email
                                                 password:(NSString *)password
                                               email_code:(NSString *)email_code
                                              invite_code:(NSString *)invite_code
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;





@end

NS_ASSUME_NONNULL_END
