//
//  YYLoginViewModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYLoginViewModel.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "YYUserInfoModel.h"
#import "YYUserDefaluts.h"
#import "UsersDefalutMacro.h"

@interface YYLoginViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYLoginViewModel

- (NSURLSessionTask *)yy_viewModelLoginByPhoneWithPassword:(NSString *)password
                                                    mobile:(NSString *)mobile
                                                  areaCode:(NSString *)areaCode
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:areaCode forKey:@"AreaCode"];
    [dic setValue:mobile forKey:@"MobilePhone"];
    [dic setValue:password forKey:@"Passwd"];
    return [self.apiRequest yy_postRequsetWithUrlString:KPhoneLogin parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            YYUserInfoModel *userInfo = [YYUserInfoModel yy_modelWithJSON:model.data];
            if (userInfo.Access_Token) {
                [YYUserDefaluts yy_setValue:userInfo.Access_Token forkey:kAccessToken];
            }
            if (userInfo.fee) {
                [YYUserDefaluts yy_setWithdrawalPoundage:userInfo.fee];
            }
            if (success) {
                success(userInfo);
            }
        } else {
            if (success) {
                success(model.msg);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelLoginByMailWithPassword:(NSString *)password
                                                     mail:(NSString *)mail
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:mail forKey:@"Mail"];
    return [self.apiRequest yy_postRequsetWithUrlString:KMailLogin parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            YYUserInfoModel *userInfo = [YYUserInfoModel yy_modelWithJSON:model.data];
            if (userInfo.Access_Token) {
                [YYUserDefaluts yy_setValue:userInfo.Access_Token forkey:kAccessToken];
            }
            if (userInfo.fee) {
                [YYUserDefaluts yy_setWithdrawalPoundage:userInfo.fee];
            }
            if (success) {
                success(userInfo);
            } else {
                if (success) {
                    success(model.msg);
                }
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
