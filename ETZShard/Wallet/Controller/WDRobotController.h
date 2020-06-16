//
//  WDRobotController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDRobotController : WDBaseFunctionController

- (instancetype)initAccountModel:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
