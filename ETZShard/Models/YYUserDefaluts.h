//
//  YYUserDefaluts.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsersDefalutMacro.h"

@class AccountModel;
NS_ASSUME_NONNULL_BEGIN

@interface YYUserDefaluts : NSObject

+ (void)yy_setAccountModelIndex:(NSInteger)index;
+ (NSInteger)yy_getAccountModelIndex;
+ (void)yy_updateAccountIndex:(AccountModel *)model;

+ (void)yy_setValue:(id)value forkey:(NSString *)key;

+ (id)yy_getValueForKey:(NSString *)key;

+ (void)yy_setIsRegister:(BOOL)isRegister;

+ (BOOL)yy_getIsRegister;

+ (void)yy_setIsLogin:(BOOL)isLogin;

+ (BOOL)yy_getIsLgoin;

+ (void)yy_setAccessTokenCache:(NSString *)token;

+ (NSString *)yy_getAccessTokeCache;

+ (void)yy_removeAccessTokenCache;

+ (void)yy_setIsRealName:(BOOL)isRealName;

+ (BOOL)yy_getIsRealName;

+ (void)yy_setCurrentWalletAddress:(NSString *)address;

+ (NSString *)yy_getCurrentWalletAddress;

+ (void)yy_clearCurrentWalletAddressCache;

+ (void)yy_setWithdrawalPoundage:(NSString *)poundage;

+ (NSString *)yy_getWithdrawalPoundage;

@end

NS_ASSUME_NONNULL_END
