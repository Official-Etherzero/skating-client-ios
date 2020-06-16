//
//  YYTeamNodeHeaderView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickRewardDetailBlock)(void);

@interface YYTeamNodeHeaderView : UIView

@property (nonatomic,   copy) ClickRewardDetailBlock  rewardDetailBlock;
@property (nonatomic, strong) TeamNodeModel  *model;

@end

NS_ASSUME_NONNULL_END
