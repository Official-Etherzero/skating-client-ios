//
//  YYBaseApiRequest.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYBaseApiRequest.h"

@implementation YYBaseApiRequest

- (NSString *)proto {
    return @"https";
}
- (NSString *)protohttp {
    return @"http";
}
- (NSString *)host {
    // ubi biwan.wanlege.com
    return @"skating.wanlege.com";
}
- (NSString *)testhost {
    // etz shard
    return @"skating.wanlege.com";
}

- (NSString *)yy_getRequestUrlWithAddress:(NSString *)address {
    NSString *urlString;
#ifdef DEBUG
    urlString = [NSString stringWithFormat:@"%@://%@/%@",[self proto],[self testhost],address];
#else
    urlString = [NSString stringWithFormat:@"%@://%@/%@",[self proto],[self host],address];
#endif
    return urlString;
}

@end
