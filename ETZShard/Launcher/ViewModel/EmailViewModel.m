//
//  EmailViewModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/3.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "EmailViewModel.h"
#import "YYServerRequest.h"
#import "YYUserDefaluts.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "APIMacro.h"

@interface EmailViewModel ()

@property (nonatomic, strong) YYServerRequest *serverRequest;

@end

@implementation EmailViewModel

// 邮箱行为验证
- (NSURLSessionTask *)yy_viewModelEmailWithTokenMachine:(NSString *)tokenMachine
                                                   Type:(NSString *)type
                                                  email:(NSString *)email
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure; {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:type forKey:@"type"];
    [dic setValue:email forKey:@"email"];
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

// 邮箱不带行为验证
- (NSURLSessionTask *)yy_viewModelEmailWithType:(NSString *)type
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

- (NSURLSessionTask *)yy_viewModelBindEmailWithEmail:(NSString *)email
                                           emailcode:(NSString *)emailcode
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:email forKey:@"email"];
    [dic setValue:emailcode forKey:@"emailcode"];
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
