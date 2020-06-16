//
//  YYMillViewModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYMillViewModel : NSObject

// 查询矿机可购买数量 (机器人列表)
- (NSURLSessionTask *)yy_viewModelNumberMinersCanbePurchasedSuccess:(successBlock _Nullable)success
                                                            failure:(failureBlock _Nullable)failure;

// 矿机购买接口
- (NSURLSessionTask *)yy_viewModelMiningMachinePurchaseWithMinerId:(NSInteger)minerId
                                                            userId:(NSString *)userId
                                                          password:(NSString *)password
                                                           success:(successBlock _Nullable)success
                                                           failure:(failureBlock _Nullable)failure;


// 正在运行的机器人列表
- (NSURLSessionTask *)yy_viewModelListOfRunningRobotsPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                       userId:(NSString *)userId
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;

// 机器人收益列表
- (NSURLSessionTask *)yy_viewModelListOfRobotBenefitsPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                       miniID:(NSInteger)miniID
                                                       userId:(NSString *)userId
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;


// 查询矿机算力统计信息
- (NSURLSessionTask *)yy_viewModelKioskOperatorForceOreStatisticsUserId:(NSString *)userId
                                                                success:(successBlock _Nullable)success
                                                                failure:(failureBlock _Nullable)failure;




// 矿机购买记录列表
- (NSURLSessionTask *)yy_viewModelMinerPurchaseRecordListPageSize:(NSInteger)pageSize
                                                      currentPage:(NSInteger)currentPage
                                                           userId:(NSString *)userId
                                                          success:(successBlock _Nullable)success
                                                          failure:(failureBlock _Nullable)failure;



// 奖励记录
- (NSURLSessionTask *)yy_viewModelRewardRecordListPageSize:(NSInteger)pageSize
                                               currentPage:(NSInteger)currentPage
                                                    userId:(NSString *)userId
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure;


@end

NS_ASSUME_NONNULL_END
