//
//  OrderCell.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(OrderModel *model);

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) OrderModel *model;
@property (nonatomic,   copy) ConfirmBlock confirmBlock;


+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
