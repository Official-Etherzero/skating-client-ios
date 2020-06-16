//
//  YYSellViewModel.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYSellViewModel.h"
#import "APIMacro.h"
#import "RequestModel.h"
#import "YYModel.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "OtcDetailModel.h"

@interface YYSellViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYSellViewModel

// 创建出售 UBI 的订单
- (NSURLSessionTask *)yy_viewModelCreateSaleWithAddress:(NSString *)address
                                               password:(NSString *)password
                                                  count:(float)count
                                                  price:(float)price
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:@(count) forKey:@"Count"];
    [dic setValue:@(price) forKey:@"Price"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_CreateSale parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if (success) {
                success([NSString stringWithFormat:@"%ld",(long)model.code]);
            } else {
                if (success) {
                    success(model.msg);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 设置 USDT 地址
- (NSURLSessionTask *)yy_viewModelSetUsdtAddressWithAddress:(NSString *)address
                                                   password:(NSString *)password
                                                usdtAddress:(NSString *)usdtAddress
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure {
    // 0x0608c675b547a8e17c53f921c7ac91c368a657d6
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:address forKey:@"USDTAddr"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_SetUSDTAddress parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if (success) {
                success([NSString stringWithFormat:@"%ld",(long)model.code]);
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

// OTC 详情
- (NSURLSessionTask *)yy_viewModelGetInfoWithAddress:(NSString *)address
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_GetOTCInfo parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            OtcDetailModel *detail = [OtcDetailModel yy_modelWithJSON:model.data];
            if (success) {
                success(detail);
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

// 取消出售 UBI
- (NSURLSessionTask *)yy_viewModelSaleCancelWithAddress:(NSString *)address
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_SaleCancel parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if (success) {
                success([NSString stringWithFormat:@"%ld",(long)model.code]);
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

// 查看卖单详情
- (NSURLSessionTask *)yy_viewModelSaleDetailWithAddress:(NSString *)address
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_SaleDetail parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (id obj in model.data) {
                OrderDetailModel *item = [OrderDetailModel yy_modelWithJSON:obj];
                [arr addObject:item];
            }
            if (success) {
                success(arr.firstObject);
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

// 确定想购买
- (NSURLSessionTask *)yy_viewModelConfirmBuyWithAddress:(NSString *)address
                                               password:(NSString *)password
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    [dic setValue:password forKey:@"Passwd"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_ConfirmBuy parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            // 0 成功
            if (success) {
                success(@"0");
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

// 确定不想购买
- (NSURLSessionTask *)yy_viewModelCancelBuyWithAddress:(NSString *)address
                                               orderId:(NSString *)orderId
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_CancelBuy parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if (success) {
                success(@"0");
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

// 填写 hash
- (NSURLSessionTask *)yy_viewModelSetHashWithAddress:(NSString *)address
                                             orderId:(NSString *)orderId
                                                hash:(NSString *)hash
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    [dic setValue:hash forKey:@"Hash"];
    return [self.apiRequest yy_postRequsetWithUrlString:Buy_SetHash parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (id obj in model.data) {
                OrderDetailModel *item = [OrderDetailModel yy_modelWithJSON:obj];
                [arr addObject:item];
            }
            if (success) {
                success(arr.firstObject);
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

// 列出所有卖单
- (NSURLSessionTask *)yy_viewModelListOrdersWithPage:(NSInteger)page
                                            pageSize:(NSInteger)pageSize
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_ListOrders parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                OrderModel *order = [OrderModel yy_modelWithJSON:obj];
                [arr addObject:order];
            }
            if (success) {
                success(arr);
            }
        } else {
            if (success) {
                if (success) {
                    success(model.msg);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#warning - todo
// 列出我的买单
- (NSURLSessionTask *)yy_viewModelListBuiesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    [dic setValue:address forKey:@"Address"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_ListBuies parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                OrderModel *order = [OrderModel yy_modelWithJSON:obj];
                [arr addObject:order];
            }
            if (success) {
                success(arr);
            }
        } else {
            if (success) {
                if (success) {
                    success(model.msg);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#warning - todo
// 列出我的卖单
- (NSURLSessionTask *)yy_viewModelListSalesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    [dic setValue:address forKey:@"Address"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_ListSales parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = @[].mutableCopy;
            for (id obj in model.data) {
                OrderModel *order = [OrderModel yy_modelWithJSON:obj];
                [arr addObject:order];
            }
            if (success) {
                success(arr);
            }
        } else {
            if (success) {
                if (success) {
                    success(model.msg);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 确认订单的完成情况
- (NSURLSessionTask *)yy_viewModelConfrimOrderWithAddress:(NSString *)address
                                                  orderId:(NSString *)orderId
                                                 password:(NSString *)password
                                                   status:(NSInteger)status
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:address forKey:@"Address"];
    [dic setValue:orderId forKey:@"OrderID"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:@(status) forKey:@"Status"];
    return [self.apiRequest yy_postRequsetWithUrlString:Sale_ConfirmOrder parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.code == 0) {
            if (success) {
                success(@"0");
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
