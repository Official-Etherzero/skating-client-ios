//
//  OrderDetailView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiningInfosModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(NSString *psd);
typedef void(^CancelBlock)(void);

@interface OrderDetailView : UIView

+ (instancetype)showOrderDetailViewWithMiningInfo:(MiningInfosModel *)model
                                     confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                      cancelBlock:(CancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
