//
//  MinerRewardModel.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "MinerRewardModel.h"

@class MinerRewardItem;
@implementation MinerRewardItem

@end

@implementation MinerRewardModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"MiningAwardList":[MinerRewardItem class]};
}

@end
