//
//  RegisterViewModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "RegisterViewModel.h"
#import "YYServerRequest.h"
#import "YYUserDefaluts.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "APIMacro.h"

@interface RegisterViewModel ()

@property (nonatomic, strong) YYServerRequest *serverRequest;

@end

@implementation RegisterViewModel

- (NSURLSessionTask *)yy_viewModelRegisterWithMachineCode:(NSString *)machineCode
                                                   mobile:(NSString *)mobile
                                                     area:(NSString *)area
                                                 password:(NSString *)password
                                              mobile_code:(NSString *)mobile_code
                                              invite_code:(NSString *)invite_code
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"password"];
    [dic setValue:area forKey:@"area"];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:mobile_code forKey:@"mobile_code"];
    [dic setValue:invite_code forKey:@"invite_code"];
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

- (NSURLSessionTask *)yy_viewModelRegisterWithMachineCode:(NSString *)machineCode
                                                    email:(NSString *)email
                                                 password:(NSString *)password
                                               email_code:(NSString *)email_code
                                              invite_code:(NSString *)invite_code
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"password"];
    [dic setValue:email forKey:@"email"];
    [dic setValue:email_code forKey:@"email_code"];
    [dic setValue:invite_code forKey:@"invite_code"];
    [dic setValue:nil forKey:@"token"];
    [dic setValue:nil forKey:@"uid"];
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
