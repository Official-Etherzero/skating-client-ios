//
//  RobotTopView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateStatisticalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RobotTopView : UIView

@property (nonatomic, strong) CalculateStatisticalModel *model;
@property (nonatomic,   copy) NSString *balance;

@end

NS_ASSUME_NONNULL_END
