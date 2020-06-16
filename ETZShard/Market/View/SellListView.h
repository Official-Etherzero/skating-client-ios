//
//  SellListView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SellBlock)(OrderModel *model);

@interface SellListView : UIView

@property (nonatomic,  copy) NSArray<OrderModel *> *models;
@property (nonatomic,  copy) SellBlock sellBlock;

@end

NS_ASSUME_NONNULL_END
