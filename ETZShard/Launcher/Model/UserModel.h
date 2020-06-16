//
//  UserModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/2.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic,  copy) NSString *Access_Token;
@property (nonatomic,  copy) NSString *ETZ;
@property (nonatomic,  copy) NSString *RechargeAddr;
@property (nonatomic,  copy) NSString *UserID;
@property (nonatomic,  copy) NSString *WalletAddr;

@end

NS_ASSUME_NONNULL_END
