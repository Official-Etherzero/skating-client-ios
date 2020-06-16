//
//  RobotsListCell.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiningInfosModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BuyMinerBlock)(NSInteger minerId);

@interface RobotsListCell : UITableViewCell

@property (nonatomic, strong) MiningInfosModel *model;
@property (nonatomic,   copy) BuyMinerBlock    buyMinerBlock;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
