//
//  SecurityCell.h
//  ExchangeClientForIOS
//
//  Created by yang on 2020/1/14.
//  Copyright © 2020 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecurityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecurityCell : UITableViewCell

@property (nonatomic, strong) SecurityModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
