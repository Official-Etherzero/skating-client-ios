//
//  LoginViewModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "LoginViewModel.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "LoginModel.h"
#import "YYUserDefaluts.h"
#import "UsersDefalutMacro.h"
#import "YYServerRequest.h"
#import "APIMacro.h"
#import "UserModel.h"

@interface LoginViewModel ()

@property (nonatomic, strong) YYServerRequest *serverRequest;

@end

@implementation LoginViewModel

- (NSURLSessionTask *)yy_viewModelLoginWithMachineCode:(NSString *)machineCode
                                                  area:(NSString *)area
                                                 email:(NSString *)email
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:area forKey:@"area"];
    [dic setValue:email forKey:@"email"];
    [dic setValue:password forKey:@"password"];
    [self.serverRequest.sessionManager.requestSerializer setValue:machineCode forHTTPHeaderField:@""];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelLoginSafetyVerificationEmail:(NSString *)email
                                                       success:(successBlock _Nullable)success
                                                       failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:email forKey:@"email"];
    return [self.serverRequest yy_postRequsetWithUrlString:@"" parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelLoginSafetyVerificationArea:(NSString *)area
                                                        email:(NSString *)email
                                                     password:(NSString *)password
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:area forKey:@"area"];
    [dic setValue:email forKey:@"email"];
    [dic setValue:password forKey:@"password"];
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
