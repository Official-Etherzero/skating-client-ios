//
//  YYNodeViewModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"
#import "APIMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYNodeViewModel : NSObject

/*
 // add marco 节点接口
 // 购买节点
 #define KBuyNode         @"ubi/mining/buyNode"
 // 领取免费节点
 #define KFreeNode        @"ubi/mining/buyFreeNode"
 // 我的节点列表
 #define KMyNodeList      @"ubi/mining/getMyNodeList"
 // 节点收益记录列表
 #define KNodeRewardList  @"ubi/mining/getNodeRewardList"
 // 团队收益记录列表
 #define KTeamRewardList  @"ubi/mining/getTeamRewardList"
 */

// 节点列表
- (NSURLSessionTask *)yy_viewModelGetNodeListSuccess:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// node id 1.2.3
- (NSURLSessionTask *)yy_viewModelBuyNodeWithToken:(NSString *)token
                                            nodeId:(NSInteger)nodeId
                                          password:(NSString *)password
                                           success:(successBlock _Nullable)success
                                           failure:(failureBlock _Nullable)failure;

// 获取免费节点
- (NSURLSessionTask *)yy_viewModelGetFreeNodeWithToken:(NSString *)token
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 我的节点列表
- (NSURLSessionTask *)yy_viewModelMyNodeListWithPageSize:(NSInteger)pageSize
                                             currentPage:(NSInteger)currentPage
                                                   token:(NSString *)token
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure;
// 节点收益记录列表
- (NSURLSessionTask *)yy_viewModelGetNodeRewardListWithPageSize:(NSInteger)pageSize
                                                    currentPage:(NSInteger)currentPage
                                                         nodeId:(NSInteger)nodeId
                                                          token:(NSString *)token
                                                        success:(successBlock _Nullable)success
                                                        failure:(failureBlock _Nullable)failure;

// 团队收益列表
- (NSURLSessionTask *)yy_viewModelGetTeamRewardListWithPageSize:(NSInteger)pageSize
                                                    currentPage:(NSInteger)currentPage
                                                          token:(NSString *)token
                                                        success:(successBlock _Nullable)success
                                                        failure:(failureBlock _Nullable)failure;

// 团队节点列表
- (NSURLSessionTask *)yy_viewModelGetTeamNodeListWithPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                        token:(NSString *)token
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;
// 提前释放节点
- (NSURLSessionTask *)yy_viewModelReleaseNodeWithNodeId:(NSInteger)nodeId
                                               password:(NSString *)password
                                                  token:(NSString *)token
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;

// 0:ETZ充提， 3:节点收益 , 4:团队收益 ，6:签到收益, 7直推奖励收益
// 收益详情
- (NSURLSessionTask *)yy_viewModelGetRewardDetailWithPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                         type:(NSInteger)type
                                                        token:(NSString *)token
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure;


@end

NS_ASSUME_NONNULL_END
