//
//  NodeOrderDetailView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(NSString *psd);
typedef void(^CancelBlock)(void);

@interface NodeOrderDetailView : UIView

+ (instancetype)showOrderDetailViewWithModel:(NodeModel *)model
                                confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                 cancelBlock:(CancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
