//
//  UserListViewModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "UserListViewModel.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import "YYUserDefaluts.h"

@implementation UserListViewModel

+ (void)yy_viewModelGetListViewDatasBlock:(void(^)(SettingDataSource *dataSource))block {
    NSMutableArray * firstArr = [NSMutableArray array];
    NSMutableArray * secondArr = [NSMutableArray array];
    SettingDataSource *dataSource = [[SettingDataSource alloc] init];
    NSString *verifyStr = [YYUserDefaluts yy_getIsRealName] ? YYStringWithKey(@"已认证") : YYStringWithKey(@"未认证");
    [firstArr addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"shiming" title:YYStringWithKey(@"实名认证") desc:verifyStr  rowType:SettingRowTypeDescArrow],
                                    [SettingRowModel modelWithImageName:@"anquan" title:YYStringWithKey(@"安全中心") rowType:SettingRowTypeArrow],
                                    [SettingRowModel modelWithImageName:@"shezhi" title:YYStringWithKey(@"偏好设置") rowType:SettingRowTypeArrow]]];
    
    [secondArr addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"yaoqing" title:YYStringWithKey(@"邀请好友") rowType:SettingRowTypeArrow],
                                     [SettingRowModel modelWithImageName:@"gonggao" title:YYStringWithKey(@"公告中心") rowType:SettingRowTypeArrow]]];
    
    dataSource.sections = @[[SettingHeaderModel modelWithTitle:@"" cells:firstArr],
                            [SettingHeaderModel modelWithTitle:@"" cells:secondArr]].mutableCopy;
    block(dataSource);
}


@end
