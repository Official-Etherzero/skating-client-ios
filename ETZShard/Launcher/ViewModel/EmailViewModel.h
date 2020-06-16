//
//  EmailViewModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/3.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIMVVMKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmailViewModel : NSObject

// 邮箱行为验证
- (NSURLSessionTask *)yy_viewModelEmailWithTokenMachine:(NSString *)tokenMachine
                                                   Type:(NSString *)type
                                                  email:(NSString *)email
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;
// 邮箱不带行为验证
- (NSURLSessionTask *)yy_viewModelEmailWithType:(NSString *)type
                                          token:(NSString *)token
                                            uid:(NSString *)uid
                                        success:(successBlock _Nullable)success
                                        failure:(failureBlock _Nullable)failure;

// 邮箱绑定  只有绑定没有解绑
- (NSURLSessionTask *)yy_viewModelBindEmailWithEmail:(NSString *)email
                                           emailcode:(NSString *)emailcode
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
