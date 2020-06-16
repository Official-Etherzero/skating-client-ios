//
//  OrderDetailCell.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailCell : UITableViewCell

@property (nonatomic, strong) OrderModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
