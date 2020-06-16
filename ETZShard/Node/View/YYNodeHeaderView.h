//
//  YYNodeHeaderView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NodeChargeBlock)(void);
typedef void(^NodeWithdrawalBlock)(void);
typedef void(^NodeDetailBlock)(void);

@interface YYNodeHeaderView : UIView

@property (nonatomic, copy) NSString            *balnace;
@property (nonatomic, copy) NodeChargeBlock     chargeBlock;
@property (nonatomic, copy) NodeWithdrawalBlock withdrawalBlock;
@property (nonatomic, copy) NodeDetailBlock     detailBlock;

@end

NS_ASSUME_NONNULL_END
