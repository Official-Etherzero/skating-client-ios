//
//  YYUserListView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YYUserListViewDelegate <NSObject>

- (void)yy_clickViewController:(nullable UIViewController *)vc;

@end

@interface YYUserListView : UIView

@property (nonatomic, strong) SettingDataSource *dataSource;
@property (nonatomic,   weak) id<YYUserListViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
