//
//  MySelfNodeModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "MySelfNodeModel.h"

@class NodeDetailModel;
@implementation NodeDetailModel
@end

@implementation MySelfNodeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"UserNodeList":[NodeDetailModel class]};
}

@end
