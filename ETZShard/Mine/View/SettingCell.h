//
//  SettingCell.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/22.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : UITableViewCell

@property (nonatomic,  copy) NSString *title;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
