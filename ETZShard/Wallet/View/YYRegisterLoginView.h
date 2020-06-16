//
//  YYRegisterLoginView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RegisterConfirmBlock)(NSString *inviteCode,NSString *psd,NSString *confirmPsw);
typedef void(^CancelRegisterBlock)(void);

@interface YYRegisterLoginView : UIView


+ (instancetype)showRegisterLoginViewBlock:(RegisterConfirmBlock)block cancelBlock:(CancelRegisterBlock)cancelBlock;



@end

NS_ASSUME_NONNULL_END
