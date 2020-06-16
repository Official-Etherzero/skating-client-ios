//
//  MarketFuctionView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MarketFuctionViewDelegate <NSObject>

- (void)yy_showPageViewIndex:(NSInteger)index;

@end

@interface MarketFuctionView : UIView

@property (nonatomic,  weak) id<MarketFuctionViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
