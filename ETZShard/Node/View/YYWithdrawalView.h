//
//  YYWithdrawalView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WithdrawalConfirmBlock)(NSString *dataStr,NSString *address,NSString *psw);
typedef void(^WithdrawalCancelBlock)(void);

@interface YYWithdrawalView : UIView

+ (instancetype)showWithdrawalViewBlock:(WithdrawalConfirmBlock)block
                            cancelBlock:(WithdrawalCancelBlock _Nullable)cancelBlock;


@end

NS_ASSUME_NONNULL_END
