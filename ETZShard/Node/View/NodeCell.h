//
//  NodeCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NodeCell : UITableViewCell

@property (nonatomic, strong) NodeModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
