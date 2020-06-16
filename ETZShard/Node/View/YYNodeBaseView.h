//
//  YYNodeBaseView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YYNodeBaseView;

typedef void(^NodeViewTouchBlock)(YYNodeBaseView *view);

@interface YYNodeBaseView : UIView

@property (nonatomic,   copy) NodeViewTouchBlock  touchBlock;

@end

NS_ASSUME_NONNULL_END
