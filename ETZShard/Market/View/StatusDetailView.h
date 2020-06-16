//
//  StatusDetailView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/30.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "YYEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatusDetailView : UIView

- (instancetype)initWithOrderModel:(OrderModel *)model status:(OrderStatus)status;

@end

NS_ASSUME_NONNULL_END
