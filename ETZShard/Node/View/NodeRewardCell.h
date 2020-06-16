//
//  NodeRewardCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeRewardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NodeRewardCell : UITableViewCell

@property (nonatomic, strong) RewardModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
