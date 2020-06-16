//
//  YYRegisterViewModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYRegisterViewModel : NSObject

- (NSURLSessionTask *)yy_viewModelRegisterByPhoneWithPassword:(NSString *)password
                                                   inviteCode:(NSString *)inviteCode
                                                      randNum:(NSString *)randNum
                                                       mobile:(NSString *)mobile
                                                   verifyCode:(NSString *)verifyCode
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;

- (NSURLSessionTask *)yy_viewModelRegisterByMailWithPassword:(NSString *)password
                                                  inviteCode:(NSString *)inviteCode
                                                     randNum:(NSString *)randNum
                                                        mail:(NSString *)mail
                                                  verifyCode:(NSString *)verifyCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure;


@end

NS_ASSUME_NONNULL_END
