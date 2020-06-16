//
//  RunningRobotCell.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunningRobotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunningRobotCell : UITableViewCell

@property (nonatomic, strong) RunningRobotModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
