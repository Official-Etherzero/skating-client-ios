//
//  BlanceModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlanceModel : NSObject

/**
 "UserID": "integer,用户ID",
 "UBIAddr": "string,系统地址",
 "UBIIN": "double,场内余额，刚注册默认为0",
 "UBIOUT": "double,场外余额，刚注册默认为0"
 */

@property (nonatomic,  copy) NSString *UBIIN;  // 交易账户
@property (nonatomic,  copy) NSString *UBIOUT; // 机器人账户
//@property (nonatomic,  copy) NSString *blance; // 钱包余额

@end

NS_ASSUME_NONNULL_END
