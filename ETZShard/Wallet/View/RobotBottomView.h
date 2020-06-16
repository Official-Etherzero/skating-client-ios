//
//  RobotBottomView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddMinerBlock)(void);

@interface RobotBottomView : UIView

@property (nonatomic, copy) AddMinerBlock addMinerBlock;

- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
