//
//  YYNodeViewModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeViewModel.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "TeamNodeModel.h"
#import "MySelfNodeModel.h"
#import "NodeModel.h"
#import "NodeRewardModel.h"
#import "DetailModel.h"

@interface YYNodeViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYNodeViewModel

// 节点列表
- (NSURLSessionTask *)yy_viewModelGetNodeListSuccess:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    return [self.apiRequest yy_postRequsetWithUrlString:KNodeList parm:nil success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                NodeModel *nodeModel = [NodeModel yy_modelWithJSON:obj];
                [arr addObject:nodeModel];
            }
            if (success) {
                success(arr);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// node id 1.2.3
- (NSURLSessionTask *)yy_viewModelBuyNodeWithToken:(NSString *)token
                                            nodeId:(NSInteger)nodeId
                                          password:(NSString *)password
                                           success:(successBlock _Nullable)success
                                           failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:@(nodeId) forKey:@"NodeID"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KBuyNode parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 免费节点
- (NSURLSessionTask *)yy_viewModelGetFreeNodeWithToken:(NSString *)token
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KFreeNode parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 我的节点列表
- (NSURLSessionTask *)yy_viewModelMyNodeListWithPageSize:(NSInteger)pageSize
                                              currentPage:(NSInteger)currentPage
                                                    token:(NSString *)token
                                                  success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KMyNodeList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            MySelfNodeModel *nodeModel = [MySelfNodeModel yy_modelWithJSON:model.data];
            if (success) {
                success(nodeModel);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
// 节点收益记录列表
- (NSURLSessionTask *)yy_viewModelGetNodeRewardListWithPageSize:(NSInteger)pageSize
                                                    currentPage:(NSInteger)currentPage
                                                         nodeId:(NSInteger)nodeId
                                                          token:(NSString *)token
                                                        success:(successBlock _Nullable)success
                                                        failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:@(nodeId) forKey:@"NodeID"];
    return [self.apiRequest yy_postRequsetWithUrlString:KNodeRewardList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            NodeRewardModel *reward = [NodeRewardModel yy_modelWithJSON:model.data];
            if (success) {
                success(reward);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 团队收益列表
- (NSURLSessionTask *)yy_viewModelGetTeamRewardListWithPageSize:(NSInteger)pageSize
                                                    currentPage:(NSInteger)currentPage
                                                          token:(NSString *)token
                                                        success:(successBlock _Nullable)success
                                                        failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KTeamRewardList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                RewardModel *reward = [RewardModel yy_modelWithJSON:obj];
                [arr addObject:reward];
            }
            if (success) {
                success(arr);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 团队节点列表
- (NSURLSessionTask *)yy_viewModelGetTeamNodeListWithPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                        token:(NSString *)token
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KTeamNodeList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.data) {
            TeamNodeModel *teamNode = [TeamNodeModel yy_modelWithJSON:model.data];
            if (success) {
                success(teamNode);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
// 提前释放节点
- (NSURLSessionTask *)yy_viewModelReleaseNodeWithNodeId:(NSInteger)nodeId
                                               password:(NSString *)password
                                                  token:(NSString *)token
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:@(nodeId) forKey:@"NodeID"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KReleaseNode parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)yy_viewModelGetRewardDetailWithPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                         type:(NSInteger)type
                                                        token:(NSString *)token
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:@(type) forKey:@"Type"];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:KRewardDetail parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        NSArray *arr = model.data[@"UserNodeList"];
        if (arr) {
            NSMutableArray *objs = @[].mutableCopy;
            for (id obj in arr) {
                DetailModel *detail = [DetailModel yy_modelWithJSON:obj];
                [objs addObject:detail];
            }
            if (success) {
                success(objs);
            }
        } else {
            if (success) {
                success(model.msg);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - lazy

- (YYServerRequest *)apiRequest {
    if (!_apiRequest) {
        _apiRequest = [[YYServerRequest alloc] init];
    }
    return _apiRequest;
}


@end
