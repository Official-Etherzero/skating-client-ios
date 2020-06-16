//
//  MessageViewModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/29.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "MessageViewModel.h"
#import "YYServerRequest.h"
#import "YYUserDefaluts.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "APIMacro.h"

@interface MessageViewModel ()

@property (nonatomic, strong) YYServerRequest *serverRequest;

@end


@implementation MessageViewModel

- (NSURLSessionTask *)yy_viewModelMessageWithTokenMachine:(NSString *)tokenMachine
                                                     Type:(NSString *)type
                                                     area:(NSString *)area
                                                   mobile:(NSString *)mobile
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:type forKey:@"type"];
    [dic setValue:area forKey:@"area"];
    [dic setValue:mobile forKey:@"mobile"];
    [self.serverRequest.sessionManager.requestSerializer setValue:tokenMachine forHTTPHeaderField:@""];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 短信不带行为验证
- (NSURLSessionTask *)yy_viewModelMessageWithType:(NSString *)type
                                            token:(NSString *)token
                                              uid:(NSString *)uid
                                          success:(successBlock _Nullable)success
                                          failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:type forKey:@"type"];
    [dic setValue:token forKey:@"token"];
    [dic setValue:uid forKey:@"uid"];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 关闭手机验证
- (NSURLSessionTask *)yy_viewModelCloseMobileWithMachineCode:(NSString *)machineCode
                                                  mobileCode:(NSString *)mobileCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobileCode forKey:@"mobilecode"];
    [self.serverRequest.sessionManager.requestSerializer setValue:machineCode forHTTPHeaderField:@""];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelBindMobile:(NSString *)mobile
                                        area:(NSString *)area
                                  mobileCode:(NSString *)mobileCode
                                     success:(successBlock _Nullable)success
                                     failure:(failureBlock _Nullable)failure; {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobileCode forKey:@"mobilecode"];
    [dic setValue:area forKey:@"area"];
    [dic setValue:mobile forKey:@"mobile"];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelUpdateMobileWithMachineCode:(NSString *)machineCode
                                                   mobilecode:(NSString *)mobilecode
                                                newmobilecode:(NSString *)newmobilecode
                                                    newmobile:(NSString *)newmobile
                                                      newarea:(NSString *)newarea
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobilecode forKey:@"mobilecode"];
    [dic setValue:newmobilecode forKey:@"newmobilecode"];
    [dic setValue:newmobile forKey:@"newmobile"];
    [dic setValue:newarea forKey:@"newarea"];
    [self.serverRequest.sessionManager.requestSerializer setValue:machineCode forHTTPHeaderField:@""];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelOpenMobileWithMachineCode:(NSString *)machineCode
                                                 mobilecode:(NSString *)mobilecode
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobilecode forKey:@"mobilecode"];
    [self.serverRequest.sessionManager.requestSerializer setValue:machineCode forHTTPHeaderField:@""];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - lazy

- (YYServerRequest *)serverRequest {
    if (!_serverRequest) {
        _serverRequest = [[YYServerRequest alloc] init];
    }
    return _serverRequest;
}


@end
