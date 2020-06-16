//
//  YYChargeView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChargeConfirmBlock)(NSString *chargeStr);
typedef void(^ChargeCancelBlock)(void);


@interface YYChargeView : UIView

+ (instancetype)showChargeViewBlock:(ChargeConfirmBlock)block
                        cancelBlock:(ChargeCancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
