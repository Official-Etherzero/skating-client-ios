//
//  RecordDetailCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/3.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordDetailCell : UITableViewCell

@property (nonatomic, strong) DetailModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
