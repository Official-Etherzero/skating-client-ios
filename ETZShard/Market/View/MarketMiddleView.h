//
//  MarketMiddleView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MarketMiddleViewDelegate <NSObject>

- (void)yy_selectedPayOrderView;
- (void)yy_selectedSellOrderView;
- (void)yy_selectedOrderDetailView;

@end

@interface MarketMiddleView : UIView

@property (nonatomic,  weak) id<MarketMiddleViewDelegate>delegate;

- (void)outstandingOrders:(BOOL)isHave;

@end

NS_ASSUME_NONNULL_END
