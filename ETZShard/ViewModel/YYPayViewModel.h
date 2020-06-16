//
//  YYPayViewModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYPayViewModel : NSObject

// 买单
// 创建买入的 UBI 订单
- (NSURLSessionTask *)yy_viewModelCreateBuyWithAddress:(NSString *)address
                                              password:(NSString *)password
                                                 count:(float)count
                                                 price:(float)price
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 创建者取消自己创建的订单
- (NSURLSessionTask *)yy_viewModelBuyCancelWithAddress:(NSString *)address
                                               orderId:(NSString *)orderId
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 查看买单详情
- (NSURLSessionTask *)yy_viewModelBuyDetailWithAddress:(NSString *)address
                                               orderId:(NSString *)orderId
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 确定想要买入
- (NSURLSessionTask *)yy_viewModelSureWantToBuyWithAddress:(NSString *)address
                                                  password:(NSString *)password
                                                   orderId:(NSString *)orderId
                                               usdtAddress:(NSString *)usdtAddress
                                                   success:(successBlock _Nullable)success
                                                   failure:(failureBlock _Nullable)failure;

// 确定不想买入
- (NSURLSessionTask *)yy_viewModelUnConfirmBuyWithAddress:(NSString *)address
                                                  orderId:(NSString *)orderId
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 填写 hash
- (NSURLSessionTask *)yy_viewModelSetHashWithAddress:(NSString *)address
                                             orderId:(NSString *)orderId
                                                hash:(NSString *)hash
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 确认交易
- (NSURLSessionTask *)yy_viewModelConfrimOrderWithAddress:(NSString *)address
                                                  orderId:(NSString *)orderId
                                                 password:(NSString *)password
                                                   status:(NSInteger)status
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;


// 列出所有订单(买单)
- (NSURLSessionTask *)yy_viewModelListOrdersWithPage:(NSInteger)page
                                            pageSize:(NSInteger)pageSize
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 列出我的所有买单 （接口暂时弃用）
- (NSURLSessionTask *)yy_viewModelListBuiesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure;

// 列出我的所有卖单 （接口暂时弃用）
- (NSURLSessionTask *)yy_viewModelListSalesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure;


@end

NS_ASSUME_NONNULL_END
