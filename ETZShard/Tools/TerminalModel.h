//
//  TerminalModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/1/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalModel : NSObject

+ (NSString *)getUUID;

+ (NSString *)getMacAddress;

+ (NSString *)wifiMacAddress;

+ (NSString *)getPlatform;

+ (NSString *)getRandNumStr;

@end

NS_ASSUME_NONNULL_END
