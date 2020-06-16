//
//  SellDetailView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DismissBlock)(void);

@interface SellDetailView : UIView

- (instancetype)initWithOrderModel:(OrderModel *)model;

@property (nonatomic, assign) NSInteger  senconds;
@property (nonatomic,   copy) DismissBlock  dismissBlock;

@end

NS_ASSUME_NONNULL_END
