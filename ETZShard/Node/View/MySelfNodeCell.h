//
//  MySelfNodeCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySelfNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MySelfNodeCell : UITableViewCell

@property (nonatomic, strong) NodeDetailModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
