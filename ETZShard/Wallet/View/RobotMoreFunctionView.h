//
//  RobotMoreFunctionView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidSelectedTagBlock)(NSInteger tag);

@interface RobotMoreFunctionView : UIView

@property (nonatomic,   copy) DidSelectedTagBlock selectedTagBlock;

- (instancetype)initWithIcons:(NSArray *)icons titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
