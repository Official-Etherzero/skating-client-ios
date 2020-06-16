//
//  OrderPasswordView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/1/9.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiningInfosModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(NSString *psd);
typedef void(^CancelBlock)(void);

@interface OrderPasswordView : UIView

+ (instancetype)showOrderPasswordViewWithModel:(MiningInfosModel *)model
                                  confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                   cancelBlock:(CancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
