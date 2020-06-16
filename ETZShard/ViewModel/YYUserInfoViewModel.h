//
//  YYUserInfoViewModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"
#import "APIMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYUserInfoViewModel : NSObject

// 注册
- (NSURLSessionTask *)yy_viewModelAccountRegisterWithAddress:(NSString *)address
                                                    password:(NSString *)password
                                                  inviteCode:(NSString *)inviteCode
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure;

// 用户是否注册
- (NSURLSessionTask *)yy_viewModelWhetherRegisterWithAddress:(NSString * _Nonnull)address
                                                     success:(successBlock _Nullable)success
                                                     failure:(failureBlock _Nullable)failure;

// 查询用户余额
- (NSURLSessionTask *)yy_viewModelCheckBalancesWithUserID:(NSString *)userId
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 划转 UBI
- (NSURLSessionTask *)yy_viewModelTransferUBIWithDirection:(NSInteger)direction
                                                     count:(float)count
                                                   address:(NSString *)address
                                                  password:(NSString *)password
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 提现
- (NSURLSessionTask *)yy_viewModelTransferWithdrawalWithAmout:(float)amount
                                                      address:(NSString *)address
                                                     password:(NSString *)password
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;
// 所有和我相关的订单
- (NSURLSessionTask *)yy_viewModelGetListOrdersWithPage:(NSInteger)page
                                               pageSize:(NSInteger)pageSize
                                                address:(NSString *)address
                                                   type:(NSInteger)type
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;



/*
*
// 用户信息
#define KGetUserInfo     @"ubi/account/getUserInfo"
// 提现
#define KWithdraw        @"ubi/account/withdraw"
// 提交实名认证资料
#define KRealName        @"ubi/account/realNameProfile"
// 审核实名认证
#define KRealNameCheck   @"ubi/account/realNameCheck"
// 重置密码（手机）
#define KResetPhonePSW   @"ubi/account/retsetPWDbyPhone"
// 重置密码（邮箱）
#define KResetMailPSW    @"ubi/account/retsetPWDbyMail"
// 绑定钱包地址
#define KBindWallet      @"ubi/account/bindWallet"
*/

// 用户信息
- (NSURLSessionTask *)yy_viewModelGetUserInfoWithToken:(NSString *)token
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 提现
- (NSURLSessionTask *)yy_viewModelWithdrawWithToken:(NSString *)token
                                            address:(NSString *)address
                                           password:(NSString *)password
                                             amount:(NSString *)amount
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure;

// 提交实名认证资料
- (NSURLSessionTask *)yy_viewModelRealNameWithUserId:(NSString *)userId
                                                area:(NSString *)area
                                          famliyName:(NSString *)famliyName
                                           firstName:(NSString *)firstName
                                              idType:(NSInteger)idType
                                            idNumber:(NSString *)idNumber
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 审核实名  suc  0 表示不同意，1 表示同意
- (NSURLSessionTask *)yy_viewModelCheckRealNameWithToken:(NSString *)token
                                                  userId:(NSString *)userId
                                                     suc:(NSInteger)suc
                                                  reason:(NSString *)reason
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure;
// 重置密码（手机）
- (NSURLSessionTask *)yy_viewModelResetPasswordByPhoneWithAreaCode:(NSString *)areaCode
                                                             mobil:(NSString *)mobil
                                                            newPsw:(NSString *)newPsw
                                                           success:(successBlock _Nullable)success
                                                           failure:(failureBlock _Nullable)failure;

// 重置密码（邮箱）
- (NSURLSessionTask *)yy_viewModelResetPasswordByMailWithMail:(NSString *)mail
                                                       newPsw:(NSString *)newPsw
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;
// 绑定钱包地址
- (NSURLSessionTask *)yy_viewModelBindWalletWithToken:(NSString *)token
                                              address:(NSString *)address
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure;

// 签到
- (NSURLSessionTask *)yy_viewModelSignInWithToken:(NSString *)token
                                          success:(successBlock _Nullable)success
                                          failure:(failureBlock _Nullable)failure;

// 获取实名 token
- (NSURLSessionTask *)yy_viewModelGetVerifyTokenWithToken:(NSString *)token
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 获取实名验证结果
- (NSURLSessionTask *)yy_viewModelGetVerifyResultWithToken:(NSString *)token
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure;




@end

NS_ASSUME_NONNULL_END
