//
//  WDSellCoinController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDSellCoinController : WDBaseFunctionController

- (instancetype)initViewControllerWithOrderModel:(OrderModel *)model detail:(OrderDetailModel *)detail;

@end

NS_ASSUME_NONNULL_END
