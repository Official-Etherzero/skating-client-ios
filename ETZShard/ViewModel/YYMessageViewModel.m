//
//  YYMessageViewModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYMessageViewModel.h"
#import "YYModel.h"
#import "RequestModel.h"

@interface YYMessageViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYMessageViewModel

- (NSURLSessionTask *)yy_viewModelGetSMSCodeWithAreaCode:(NSString *)areaCode
                                                  mobile:(NSString *)mobile
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:areaCode forKey:@"AreaCode"];
    [dic setValue:mobile forKey:@"MobilePhone"];
    return [self.apiRequest yy_postRequsetWithUrlString:KGetSMSCode parm:dic success:^(id responseObject) {
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

- (NSURLSessionTask *)yy_viewModelGetMailCodeWithMail:(NSString *)mail
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mail forKey:@"Mail"];
    return [self.apiRequest yy_postRequsetWithUrlString:KGetEmailCode parm:dic success:^(id responseObject) {
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

// 信息验证
- (NSURLSessionTask *)yy_viewModelVerifySMSCodeWithAreaCode:(NSString *)areaCode
                                                     mobile:(NSString *)mobile
                                                 verifyCode:(NSString *)verifyCode
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:areaCode forKey:@"AreaCode"];
    [dic setValue:mobile forKey:@"MobilePhone"];
    [dic setValue:verifyCode forKey:@"VerifyCode"];
    // verfyCode 短信验证码
    return [self.apiRequest yy_postRequsetWithUrlString:KVerifySMSCode parm:dic success:^(id responseObject) {
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

- (NSURLSessionTask *)yy_viewModelVerifyMailWithMail:(NSString *)mail
                                          verifyCode:(NSString *)verifyCode
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mail forKey:@"Mail"];
    // verfyCode 短信验证码
    [dic setValue:verifyCode forKey:@"VerfyCode"];
    return [self.apiRequest yy_postRequsetWithUrlString:KVerifyMailCode parm:dic success:^(id responseObject) {
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

- (YYServerRequest *)apiRequest {
    if (!_apiRequest) {
        _apiRequest = [[YYServerRequest alloc] init];
    }
    return _apiRequest;
}

@end
