//
//  NodeRewardModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "NodeRewardModel.h"

@class RewardModel;
@implementation RewardModel
@end

@implementation NodeRewardModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"UserNodeList":[RewardModel class]};
}

@end
