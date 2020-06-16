//
//  TerminalModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/1/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "TerminalModel.h"
#import "KeyChainStore.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#include <net/if_dl.h>
#import <net/if.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import "NSString+AES.h"

#define kKeyChainAddress @"cn.ubiwallet.com"

@implementation TerminalModel

+ (NSString *)getUUID {
    NSString * strUUID = (NSString *)[KeyChainStore load:kKeyChainAddress];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID) {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        CFRelease(uuidRef);
        //将该uuid保存到keychain
        [KeyChainStore save:kKeyChainAddress data:strUUID];
    }
    return strUUID;
}

+ (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    // MAC地址带冒号
     NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2),
     *(ptr+3), *(ptr+4), *(ptr+5)];
    
    // MAC地址不带冒号
//    NSString *outstring = [NSString
//                           stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    
    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSString *)wifiMacAddress {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *bssid = [dic objectForKey:@"BSSID"];
    
    return bssid;
}

+ (NSString *)getPlatform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
}

+ (NSString *)getRandNumStr {
    NSString *iphoneTypeString = [self getPlatform];
    NSString *uuid = [self getUUID];
    NSString *jsonString = [NSString stringWithFormat:@"{\"OSType\":\"1\",\"HTCDesire\":\"%@\",\"Mac\":\"\",\"UUID\":\"%@\"}",iphoneTypeString,uuid];
    // 暂时不加盐
    NSString *str = [jsonString yy_encryptWithAES];
    return str;
}

@end
