//
//  YYServerRequest.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYServerRequest.h"

@implementation YYServerRequest

- (NSURLSessionTask *)yy_getRequsetWithUrlString:(NSString * _Nonnull)path
                                            parm:(NSDictionary * _Nullable)parm  success:(successBlock _Nullable)success failure:(failureBlock _Nullable)failure {

    NSString *urlPath = [self yy_getRequestUrlWithAddress:path];
    NSDictionary *parameters = parm;
    return [self.sessionManager GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_postRequsetWithUrlString:(NSString * _Nonnull)path
                                             parm:(NSDictionary * _Nullable)parm  success:(successBlock _Nullable)success failure:(failureBlock _Nullable)failure {
    NSString *urlPath = [self yy_getRequestUrlWithAddress:path];
    NSDictionary *parameters = parm;
    return [self.sessionManager POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) failure(error);
        }
    }];
}

#pragma mark - lazy

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"portal"];
        [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        _sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        _sessionManager.requestSerializer.timeoutInterval = 0.0f;
    }
    return _sessionManager;
}

@end
