//
//  RunningRobotModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunningRobotModel : NSObject

/**
 @parm
 "OAmount": "integer,矿机原价",
 "Amount": "integer,矿机实际购买价格",
 "UserID": "integer,用户ID",
 "Name": "string,矿机名称",
 "MiniID": "integer,矿机ID",
 "StartTime": "date-time,开始时间",
 "ExpireTime": "date-time,到期时间",
 "RateOfProgress": "string,进度"
 */

@property (nonatomic, assign) NSInteger OAmount;
@property (nonatomic, assign) NSInteger Amount;
@property (nonatomic, assign) NSInteger UserID;
@property (nonatomic,   copy) NSString  *Name;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) NSTimeInterval StartTime;
@property (nonatomic, assign) NSTimeInterval ExpireTime;
@property (nonatomic,   copy) NSString  *RateOfProgress;

@end

NS_ASSUME_NONNULL_END
