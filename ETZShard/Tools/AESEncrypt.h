//
//  AESEncrypt.h
//  UBIClientForiOS
//
//  Created by yang on 2020/1/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESEncrypt : NSObject

// 加密
+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

// 解密
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

+ (NSString *)yy_encryptWithAES:(NSString *)plainText;

@end

NS_ASSUME_NONNULL_END
