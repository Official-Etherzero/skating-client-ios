//
//  AccountsView.h
//  UBIClientForiOS
//
//  Created by etz on 2020/1/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEnum.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapAccountBlock)(NSInteger index);

@interface AccountsView : UIView

@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initViewTapsBlock:(TapAccountBlock)accountBlock selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
