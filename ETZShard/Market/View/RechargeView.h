//
//  RechargeView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(NSString *address);
typedef void(^CancelBlock)(void);

@interface RechargeView : UIView

+ (instancetype)showRechargeViewWithUsdtAddress:(NSString *)address
                                   confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                    cancelBlock:(CancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
