//
//  YYUserInfoViewModel.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYUserInfoViewModel.h"
#import "APIMacro.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "UserInfoModel.h"
#import "BlanceModel.h"
#import "OrderModel.h"
#import "TerminalModel.h"
#import "NSString+AES.h"
#import "YYUserInfoModel.h"
#import "VerifyModel.h"
#import "YYUserDefaluts.h"


@interface YYUserInfoViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYUserInfoViewModel

// 注册
- (NSURLSessionTask *)yy_viewModelAccountRegisterWithAddress:(NSString *)address
                                                    password:(NSString *)password
                                                  inviteCode:(NSString *)inviteCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure {
    NSString *iphoneTypeString = [TerminalModel getPlatform];
    NSString *uuid = [TerminalModel getUUID];
    NSString *jsonString = [NSString stringWithFormat:@"{\"OSType\":\"1\",\"HTCDesire\":\"%@\",\"Mac\":\"\",\"UUID\":\"%@\"}",iphoneTypeString,uuid];
    NSString *str = [jsonString yy_encryptWithAES];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:inviteCode forKey:@"InviteCode"];
    [dic setValue:str forKey:@"RandNum"];
    return [self.apiRequest yy_postRequsetWithUrlString:RegisterUrl parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            UserInfoModel *info = [UserInfoModel yy_modelWithJSON:model.data];
            if (success) {
                success(info);
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

// 用户是否注册
- (NSURLSessionTask *)yy_viewModelWhetherRegisterWithAddress:(NSString * _Nonnull)address
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    return [self.apiRequest yy_postRequsetWithUrlString:WhetherRegister parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            UserInfoModel *info = [UserInfoModel yy_modelWithJSON:model.data];
            if (success) {
                success(info);
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

// 查询用户余额
- (NSURLSessionTask *)yy_viewModelCheckBalancesWithUserID:(NSString *)userId
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_getRequsetWithUrlString:UserBalance parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            BlanceModel *blance = [BlanceModel yy_modelWithJSON:model.data];
            if (success) {
                success(blance);
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

// 划转 UBI
- (NSURLSessionTask *)yy_viewModelTransferUBIWithDirection:(NSInteger)direction
                                                     count:(float)count
                                                   address:(NSString *)address
                                                  password:(NSString *)password
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(direction) forKey:@"Direction"];
    [dic setValue:@(count) forKey:@"Count"];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:password forKey:@"Passwd"];
    return [self.apiRequest yy_postRequsetWithUrlString:TransferUBI parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if ([model.data isKindOfClass:[NSDictionary class]]) {
                BlanceModel *blance = [BlanceModel yy_modelWithJSON:model.data];
                if (success) {
                    success(blance);
                }
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

// 提现
- (NSURLSessionTask *)yy_viewModelTransferWithdrawalWithAmout:(float)amount
                                                      address:(NSString *)address
                                                     password:(NSString *)password
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(amount) forKey:@"Amount"];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:password forKey:@"Passwd"];
    return [self.apiRequest yy_postRequsetWithUrlString:WithdrawalUBI parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if ([model.data isKindOfClass:[NSDictionary class]]) {
                BlanceModel *blance = [BlanceModel yy_modelWithJSON:model.data];
                if (success) {
                    success(blance);
                }
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

// 所有和我相关的订单
- (NSURLSessionTask *)yy_viewModelGetListOrdersWithPage:(NSInteger)page
                                               pageSize:(NSInteger)pageSize
                                                address:(NSString *)address
                                                   type:(NSInteger)type
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:@(type) forKey:@"Type"];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    return [self.apiRequest yy_postRequsetWithUrlString:ListMyOrders parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                OrderModel *order = [OrderModel yy_modelWithJSON:obj];
                [arr addObject:order];
            }
            if (success) {
                success(arr);
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


#pragma mark - add

// 用户信息
- (NSURLSessionTask *)yy_viewModelGetUserInfoWithToken:(NSString *)token
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KGetUserInfo parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            YYUserInfoModel *userInfo = [YYUserInfoModel yy_modelWithJSON:model.data];
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

// 提现
- (NSURLSessionTask *)yy_viewModelWithdrawWithToken:(NSString *)token
                                            address:(NSString *)address
                                           password:(NSString *)password
                                             amount:(NSString *)amount
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:amount forKey:@"Amount"];
    [dic setValue:address forKey:@"toAddr"];
    return [self.apiRequest yy_postRequsetWithUrlString:KWithdraw parm:dic success:^(id responseObject) {
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

// 提交实名认证资料
- (NSURLSessionTask *)yy_viewModelRealNameWithUserId:(NSString *)userId
                                                area:(NSString *)area
                                          famliyName:(NSString *)famliyName
                                           firstName:(NSString *)firstName
                                              idType:(NSInteger)idType
                                            idNumber:(NSString *)idNumber
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return [self.apiRequest yy_postRequsetWithUrlString:KRealName parm:dic success:^(id responseObject) {
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

// 审核实名  suc  0 表示不同意，1 表示同意
- (NSURLSessionTask *)yy_viewModelCheckRealNameWithToken:(NSString *)token
                                                  userId:(NSString *)userId
                                                     suc:(NSInteger)suc
                                                  reason:(NSString *)reason
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return [self.apiRequest yy_postRequsetWithUrlString:KRealNameCheck parm:dic success:^(id responseObject) {
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
// 重置密码（手机）
- (NSURLSessionTask *)yy_viewModelResetPasswordByPhoneWithAreaCode:(NSString *)areaCode
                                                             mobil:(NSString *)mobil
                                                            newPsw:(NSString *)newPsw
                                                           success:(successBlock _Nullable)success
                                                           failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:areaCode forKey:@"AreaCode"];
    [dic setValue:mobil forKey:@"MobilePhone"];
    [dic setValue:newPsw forKey:@"NewPasswd"];
    return [self.apiRequest yy_postRequsetWithUrlString:KResetPhonePSW parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 重置密码（邮箱）
- (NSURLSessionTask *)yy_viewModelResetPasswordByMailWithMail:(NSString *)mail
                                                       newPsw:(NSString *)newPsw
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mail forKey:@"Mail"];
    [dic setValue:newPsw forKey:@"NewPasswd"];
    return [self.apiRequest yy_postRequsetWithUrlString:KResetMailPSW parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
// 绑定钱包地址
- (NSURLSessionTask *)yy_viewModelBindWalletWithToken:(NSString *)token
                                              address:(NSString *)address
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KBindWallet parm:dic success:^(id responseObject) {
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

// 签到
- (NSURLSessionTask *)yy_viewModelSignInWithToken:(NSString *)token
                                          success:(successBlock _Nullable)success
                                          failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KSignIn parm:dic success:^(id responseObject) {
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

// 获取实名 token
- (NSURLSessionTask *)yy_viewModelGetVerifyTokenWithToken:(NSString *)token
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KVerifyToken parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            VerifyModel *verifyModel = [VerifyModel yy_modelWithJSON:model.data];
            if (success) {
                success(verifyModel);
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

// 获取实名验证结果
- (NSURLSessionTask *)yy_viewModelGetVerifyResultWithToken:(NSString *)token
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KVerifyResult parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            VerifyModel *verifyModel = [VerifyModel yy_modelWithJSON:model.data];
            if (success) {
                success(verifyModel);
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

#pragma mark - lazy

- (YYServerRequest *)apiRequest {
    if (!_apiRequest) {
        _apiRequest = [[YYServerRequest alloc] init];
    }
    return _apiRequest;
}


@end
