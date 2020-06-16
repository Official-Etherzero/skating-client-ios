//
//  TeamNodeModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "TeamNodeModel.h"

@class UserNodeModel;
@implementation UserNodeModel
@end

@implementation TeamNodeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"UserNodeList":[UserNodeModel class]};
}

@end
