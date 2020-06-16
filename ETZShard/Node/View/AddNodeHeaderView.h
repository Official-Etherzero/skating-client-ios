//
//  AddNodeHeaderView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNodeClickBlock)(NodeModel *model);

@interface AddNodeHeaderView : UIView

@property (nonatomic, strong) NodeModel *model;
@property (nonatomic,   copy) AddNodeClickBlock  addNodeBlock;

@end

NS_ASSUME_NONNULL_END
