//
//  YYUserDefaluts.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYUserDefaluts.h"
#import "AccountModel.h"
#import "WalletDataManager.h"

@implementation YYUserDefaluts

+ (void)yy_setAccountModelIndex:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"KLRow"];
}

+ (NSInteger)yy_getAccountModelIndex {
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"KLRow"];
    return index;
}

+ (void)yy_updateAccountIndex:(AccountModel *)model {
    NSArray *arr = [WalletDataManager getAccountsForDataBase];
    NSInteger index = 0;
    for (int i = 0; i < arr.count; i ++) {
        AccountModel *item = arr[i];
        if ([model.address isEqualToString:item.address]) {
            index = i;
        }
    }
    NSInteger currentIndex = [self yy_getAccountModelIndex];
    if (index <= currentIndex) {
        if (currentIndex > 0) {
            [self yy_setAccountModelIndex:currentIndex -1];
        }
    }
}

+ (void)yy_setValue:(id)value forkey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (id)yy_getValueForKey:(NSString *)key {
    id object = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return object;
}

+ (void)yy_setIsRegister:(BOOL)isRegister {
    [[NSUserDefaults standardUserDefaults] setBool:isRegister forKey:KIsRegisrer];
}

+ (BOOL)yy_getIsRegister {
    return [[NSUserDefaults standardUserDefaults] boolForKey:KIsRegisrer];
}

+ (void)yy_setIsLogin:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:KIsLogin];
}

+ (BOOL)yy_getIsLgoin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:KIsLogin];
}

+ (void)yy_setAccessTokenCache:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAccessToken];
}

+ (NSString *)yy_getAccessTokeCache {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
}

+ (void)yy_removeAccessTokenCache {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessToken];
}

+ (void)yy_setIsRealName:(BOOL)isRealName {
    [[NSUserDefaults standardUserDefaults] setBool:isRealName forKey:kIsRealName];
}

+ (BOOL)yy_getIsRealName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsRealName];
}

+ (void)yy_setCurrentWalletAddress:(NSString *)address {
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:kCurrentWalletAddress];
}

+ (NSString *)yy_getCurrentWalletAddress {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentWalletAddress];
}

+ (void)yy_clearCurrentWalletAddressCache {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentWalletAddress];
}

+ (void)yy_setWithdrawalPoundage:(NSString *)poundage {
   [[NSUserDefaults standardUserDefaults] setObject:poundage forKey:kPoundage];
}

+ (NSString *)yy_getWithdrawalPoundage {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPoundage];
}

@end
