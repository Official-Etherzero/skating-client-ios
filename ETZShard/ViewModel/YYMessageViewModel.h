//
//  YYMessageViewModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"
#import "APIMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYMessageViewModel : NSObject


- (NSURLSessionTask *)yy_viewModelGetSMSCodeWithAreaCode:(NSString *)areaCode
                                                  mobile:(NSString *)mobile
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure;

- (NSURLSessionTask *)yy_viewModelGetMailCodeWithMail:(NSString *)mail
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure;

// 信息验证
- (NSURLSessionTask *)yy_viewModelVerifySMSCodeWithAreaCode:(NSString *)areaCode
                                                     mobile:(NSString *)mobile
                                                 verifyCode:(NSString *)verifyCode
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure;

- (NSURLSessionTask *)yy_viewModelVerifyMailWithMail:(NSString *)mail
                                          verifyCode:(NSString *)verifyCode
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
