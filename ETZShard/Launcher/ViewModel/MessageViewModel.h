//
//  MessageViewModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/29.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIMVVMKit.h"

NS_ASSUME_NONNULL_BEGIN

/** 1、行为验证只会出现在发短信时
    2、发短信不一定要行为验证
 */
@interface MessageViewModel : NSObject

// 多个接口支持外部传参
@property (nonatomic, strong) NSDictionary *parameters;

// 短信行为验证
- (NSURLSessionTask *)yy_viewModelMessageWithTokenMachine:(NSString *)tokenMachine
                                                     Type:(NSString *)type
                                                     area:(NSString *)area
                                                   mobile:(NSString *)mobile
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;
// 短信不带行为验证
- (NSURLSessionTask *)yy_viewModelMessageWithType:(NSString *)type
                                            token:(NSString *)token
                                              uid:(NSString *)uid
                                          success:(successBlock _Nullable)success
                                          failure:(failureBlock _Nullable)failure;

// 关闭手机验证
- (NSURLSessionTask *)yy_viewModelCloseMobileWithMachineCode:(NSString *)machineCode
                                                  mobileCode:(NSString *)mobileCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure;

// 绑定手机
- (NSURLSessionTask *)yy_viewModelBindMobile:(NSString *)mobile
                                        area:(NSString *)area
                                  mobileCode:(NSString *)mobileCode
                                     success:(successBlock _Nullable)success
                                     failure:(failureBlock _Nullable)failure;

// 更改绑定手机号
- (NSURLSessionTask *)yy_viewModelUpdateMobileWithMachineCode:(NSString *)machineCode
                                                   mobilecode:(NSString *)mobilecode
                                                newmobilecode:(NSString *)newmobilecode
                                                    newmobile:(NSString *)newmobile
                                                      newarea:(NSString *)newarea
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;
// 开启手机验证 （关闭后再开启）

- (NSURLSessionTask *)yy_viewModelOpenMobileWithMachineCode:(NSString *)machineCode
                                                 mobilecode:(NSString *)mobilecode
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
