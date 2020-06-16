//
//  YYRegisterViewModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYRegisterViewModel.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "YYUserInfoModel.h"
#import "YYUserDefaluts.h"
#import "APIMacro.h"
#import "UsersDefalutMacro.h"

@interface YYRegisterViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYRegisterViewModel

- (NSURLSessionTask *)yy_viewModelRegisterByPhoneWithPassword:(NSString *)password
                                                   inviteCode:(NSString *)inviteCode
                                                      randNum:(NSString *)randNum
                                                       mobile:(NSString *)mobile
                                                   verifyCode:(NSString *)verifyCode
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:inviteCode forKey:@"InviteCode"];
    [dic setValue:randNum forKey:@"RandNum"];
    [dic setValue:mobile forKey:@"MobilePhone"];
    [dic setValue:verifyCode forKey:@"VerifyCode"];
    return [self.apiRequest yy_postRequsetWithUrlString:KPhoneRegister parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            YYUserInfoModel *userInfo = [YYUserInfoModel yy_modelWithJSON:model.data];
            [YYUserDefaluts yy_setValue:userInfo.Access_Token forkey:kAccessToken];
            if (success) {
                success(userInfo);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelRegisterByMailWithPassword:(NSString *)password
                                                  inviteCode:(NSString *)inviteCode
                                                     randNum:(NSString *)randNum
                                                        mail:(NSString *)mail
                                                  verifyCode:(NSString *)verifyCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:inviteCode forKey:@"InviteCode"];
    [dic setValue:randNum forKey:@"RandNum"];
    [dic setValue:mail forKey:@"Mail"];
    [dic setValue:verifyCode forKey:@"VerifyCode"];
    return [self.apiRequest yy_postRequsetWithUrlString:KMailRegister parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            YYUserInfoModel *userInfo = [YYUserInfoModel yy_modelWithJSON:model.data];
            [YYUserDefaluts yy_setValue:userInfo.Access_Token forkey:kAccessToken];
            if (success) {
                success(userInfo);
            }
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
