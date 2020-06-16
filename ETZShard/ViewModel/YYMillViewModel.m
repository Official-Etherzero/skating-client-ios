//
//  YYMillViewModel.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYMillViewModel.h"
#import "APIMacro.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "CalculateStatisticalModel.h"
#import "RunningRobotModel.h"
#import "MiningInfosModel.h"
#import "RobotBenefitsModel.h"
#import "MiningBuyRecordsModel.h"
#import "MinerRewardModel.h"
#import "YYUserDefaluts.h"
#import "YYLanguageTool.h"

@interface YYMillViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYMillViewModel

// 查询矿机可购买数量
- (NSURLSessionTask *)yy_viewModelNumberMinersCanbePurchasedSuccess:(successBlock _Nullable)success
                                                            failure:(failureBlock _Nullable)failure {
    return [self.apiRequest yy_getRequsetWithUrlString:QueryMinersNumber parm:nil success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            NSArray *infos = [model.data objectForKey:@"MiningInfos"];
            for (id obj in infos) {
                MiningInfosModel *item = [MiningInfosModel yy_modelWithJSON:obj];
                [arr addObject:item];
            }
            if (success) {
                success(arr);
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

// 矿机购买接口
- (NSURLSessionTask *)yy_viewModelMiningMachinePurchaseWithMinerId:(NSInteger)minerId
                                                            userId:(NSString *)userId
                                                          password:(NSString *)password
                                                           success:(successBlock _Nullable)success
                                                           failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(minerId) forKey:@"MiniID"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:BuyMiner parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (success && model.code == 0) {
            // code = 0 。成功，否则失败
            success(YYStringWithKey(@"购买成功"));
        } else {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


// 正在运行的机器人列表
- (NSURLSessionTask *)yy_viewModelListOfRunningRobotsPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                       userId:(NSString *)userId
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:RunningRobots parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            NSArray *list = [model.data objectForKey:@"UserMiningList"];
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in list) {
                RunningRobotModel *item = [RunningRobotModel yy_modelWithJSON:obj];
                [arr addObject:item];
            }
            if (success) {
                success(arr);
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

// 机器人收益列表
- (NSURLSessionTask *)yy_viewModelListOfRobotBenefitsPageSize:(NSInteger)pageSize
                                                  currentPage:(NSInteger)currentPage
                                                       miniID:(NSInteger)miniID
                                                       userId:(NSString *)userId
                                                      success:(successBlock _Nullable)success
                                                      failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:@(miniID) forKey:@"MiniID"];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:RobotBenefits parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            RobotBenefitsModel *item = [RobotBenefitsModel yy_modelWithJSON:model.data];
            if (success) {
                success(item);
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


// 查询矿机算力统计信息
- (NSURLSessionTask *)yy_viewModelKioskOperatorForceOreStatisticsUserId:(NSString *)userId
                                                                success:(successBlock _Nullable)success
                                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:QueryMiningPower parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            CalculateStatisticalModel *caluculate = [CalculateStatisticalModel yy_modelWithJSON:model.data];
            if (success) {
                success(caluculate);
            }
        } else {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


// 矿机购买记录列表
- (NSURLSessionTask *)yy_viewModelMinerPurchaseRecordListPageSize:(NSInteger)pageSize
                                                      currentPage:(NSInteger)currentPage
                                                           userId:(NSString *)userId
                                                          success:(successBlock _Nullable)success
                                                          failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:MinerPurchaseList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                MiningBuyRecordsModel *item = [MiningBuyRecordsModel yy_modelWithJSON:obj];
                [arr addObject:item];
            }
            if (success) {
                success(arr);
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


// 奖励记录
- (NSURLSessionTask *)yy_viewModelRewardRecordListPageSize:(NSInteger)pageSize
                                               currentPage:(NSInteger)currentPage
                                                    userId:(NSString *)userId
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(pageSize) forKey:@"PageSize"];
    [dic setValue:@(currentPage) forKey:@"CurrentPage"];
    [dic setValue:userId forKey:@"UserID"];
    return [self.apiRequest yy_postRequsetWithUrlString:RewardRecordList parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            MinerRewardModel *item = [MinerRewardModel yy_modelWithJSON:model.data];
            if (success) {
                success(item);
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
