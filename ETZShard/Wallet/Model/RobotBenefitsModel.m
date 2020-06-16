//
//  RobotBenefitsModel.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotBenefitsModel.h"

@class MinerIncomeModel;
@implementation MinerIncomeModel;

@end
@implementation RobotBenefitsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"MiningEarningList":[MinerIncomeModel class]};
}

@end
