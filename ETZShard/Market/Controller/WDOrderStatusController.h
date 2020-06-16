//
//  WDOrderStatusController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDOrderStatusController : WDBaseFunctionController

- (instancetype)initViewControllerWithModel:(OrderModel *)model;

@end

NS_ASSUME_NONNULL_END
