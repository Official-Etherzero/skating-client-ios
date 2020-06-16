//
//  NodeRewardModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject

@property (nonatomic,   copy) NSString  *WriteTime;
@property (nonatomic, assign) NSInteger Amount;

@end

@class RewardModel;

@interface NodeRewardModel : NSObject

@property (nonatomic, assign) NSInteger Total;
@property (nonatomic, assign) NSInteger RestOfDayess;
@property (nonatomic, assign) NSInteger TotalReward;
@property (nonatomic, assign) NSInteger TotalRewardYesterday;
@property (nonatomic,   copy) NSArray<RewardModel *> *UserNodeList;

@end

NS_ASSUME_NONNULL_END
