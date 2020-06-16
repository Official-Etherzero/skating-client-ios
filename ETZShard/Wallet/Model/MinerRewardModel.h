//
//  MinerRewardModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 @parm MiningAwardList
 "AwardID": "integer,奖励记录ID",
 "MiniID": "integer,矿机ID",
 "MType": "integer,矿机类型",
 "UserID": "integer,用户ID",
 "Award": "integer,奖励金额",
 "WriteTime": "date-time,奖励时间"
 
 "Total": "integer,总记录条数",
 "TotalAward": "integer,总奖励金额"
 */

@interface MinerRewardItem : NSObject

@property (nonatomic, assign) NSInteger AwardID;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) NSInteger MType;
@property (nonatomic, assign) NSInteger UserID;
@property (nonatomic, assign) NSInteger Award;
@property (nonatomic, assign) NSTimeInterval WriteTime;


@end

@class MinerRewardItem;
@interface MinerRewardModel : NSObject

@property (nonatomic, assign) NSInteger Total;
@property (nonatomic, assign) NSInteger TotalAward;
@property (nonatomic,   copy) NSArray<MinerRewardItem *> *MiningAwardList;

@end

NS_ASSUME_NONNULL_END
