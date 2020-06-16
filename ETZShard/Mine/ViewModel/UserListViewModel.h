//
//  UserListViewModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserListViewModel : NSObject

+ (void)yy_viewModelGetListViewDatasBlock:(void(^)(SettingDataSource *dataSource))block;

@end

NS_ASSUME_NONNULL_END
