//
//  OrderListView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidSelectedBlock)(OrderModel *model);

@interface OrderListView : UIView

@property (nonatomic,  copy) NSArray<OrderModel *> *models;
@property (nonatomic,  copy) DidSelectedBlock selectedBlock;

@end

NS_ASSUME_NONNULL_END
