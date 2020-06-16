//
//  RobotTitleView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RobotTitleView : UIView

@property (nonatomic, copy) NSString *content;

- (instancetype)initWithLeftView:(NSString *)icon title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
