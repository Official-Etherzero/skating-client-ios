//
//  YYBaseApiRequest.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBaseApiRequest : NSObject

- (NSString *)proto;
- (NSString *)protohttp;
- (NSString *)host;
- (NSString *)testhost;

- (NSString *)yy_getRequestUrlWithAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
