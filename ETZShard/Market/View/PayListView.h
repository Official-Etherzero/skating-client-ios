//
//  PayListView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BuyBlock)(OrderModel *model);

@interface PayListView : UIView

@property (nonatomic, copy) NSArray<OrderModel *> *models;
@property (nonatomic, copy) BuyBlock buyBlock;

@end

NS_ASSUME_NONNULL_END
