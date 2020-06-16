//
//  WDOrderDetailController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "OrderModel.h"
#import "YYEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDOrderDetailController : WDBaseFunctionController

- (instancetype)initViewControllerWithModel:(OrderModel *)model status:(OrderStatus)status;

@end

NS_ASSUME_NONNULL_END
