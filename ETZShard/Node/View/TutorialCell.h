//
//  TutorialCell.h
//  ETZShard
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TutorialCell : UITableViewCell

@property (nonatomic, strong) TutorialModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
