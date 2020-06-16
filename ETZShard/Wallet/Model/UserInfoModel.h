//
//  UserInfoModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

/**
 *"UserID": "integer,用户ID",
 "UBIAddr": "string,系统地址",
 "UBIIN": "double,场内余额，刚注册默认为0",
 "UBIOUT": "double,场外余额，刚注册默认为0"
 */

@property (nonatomic,  copy) NSString *UBIAddr;
@property (nonatomic,  copy) NSString *UBIIN;
@property (nonatomic,  copy) NSString *UBIOUT;
@property (nonatomic,  copy) NSString *UserID;

@end

NS_ASSUME_NONNULL_END
