//
//  LoginModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject

@property (nonatomic,  copy) NSString *token;
@property (nonatomic,  copy) NSString *uid;

@end

NS_ASSUME_NONNULL_END
