//
//  MySelfNodeModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NodeDetailModel : NSObject

@property (nonatomic,   copy) NSString  *ExpireTime;
@property (nonatomic,   copy) NSString  *StartTime;
@property (nonatomic,   copy) NSString  *RewardYesterday;
@property (nonatomic,   copy) NSString  *Reward;
@property (nonatomic,   copy) NSString  *UserID;
@property (nonatomic,   copy) NSString  *OAmount;
@property (nonatomic, assign) NSInteger NodeID;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) NSInteger RestOfDay;

@end

@class NodeDetailModel;
@interface MySelfNodeModel : NSObject

@property (nonatomic, assign) NSInteger TotalCount;
@property (nonatomic,   copy) NSString  *TotalReward;
@property (nonatomic,   copy) NSString  *TotalRewardYesterday;
@property (nonatomic,   copy) NSArray<NodeDetailModel *> *UserNodeList;

@end

NS_ASSUME_NONNULL_END
