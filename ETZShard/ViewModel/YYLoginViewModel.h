//
//  YYLoginViewModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"
#import "APIMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYLoginViewModel : NSObject

- (NSURLSessionTask *)yy_viewModelLoginByPhoneWithPassword:(NSString *)password
                                                    mobile:(NSString *)mobile
                                                  areaCode:(NSString *)areaCode
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure;

- (NSURLSessionTask *)yy_viewModelLoginByMailWithPassword:(NSString *)password
                                                     mail:(NSString *)mail
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
