//
//  WDRobotDetailController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "RunningRobotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDRobotDetailController : WDBaseFunctionController

- (instancetype)initRobotDetailWithModel:(RunningRobotModel *)model;

@end

NS_ASSUME_NONNULL_END
