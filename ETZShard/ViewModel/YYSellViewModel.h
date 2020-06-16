//
//  YYSellViewModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYSellViewModel : NSObject

// 卖单
// 创建出售 UBI 的订单
- (NSURLSessionTask *)yy_viewModelCreateSaleWithAddress:(NSString *)address
                                               password:(NSString *)password
                                                  count:(float)count
                                                  price:(float)price
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;

// 设置 USDT 地址
- (NSURLSessionTask *)yy_viewModelSetUsdtAddressWithAddress:(NSString *)address
                                                   password:(NSString *)password
                                                usdtAddress:(NSString *)usdtAddress
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure;

// OTC 详情
- (NSURLSessionTask *)yy_viewModelGetInfoWithAddress:(NSString *)address
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 取消出售 UBI
- (NSURLSessionTask *)yy_viewModelSaleCancelWithAddress:(NSString *)address
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;

// 查看卖单详情
- (NSURLSessionTask *)yy_viewModelSaleDetailWithAddress:(NSString *)address
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;

// 确定想购买
- (NSURLSessionTask *)yy_viewModelConfirmBuyWithAddress:(NSString *)address
                                               password:(NSString *)password
                                                orderId:(NSString *)orderId
                                                success:(successBlock _Nullable)success
                                                failure:(failureBlock _Nullable)failure;

// 确定不想购买
- (NSURLSessionTask *)yy_viewModelCancelBuyWithAddress:(NSString *)address
                                               orderId:(NSString *)orderId
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 填写 hash
- (NSURLSessionTask *)yy_viewModelSetHashWithAddress:(NSString *)address
                                             orderId:(NSString *)orderId
                                                hash:(NSString *)hash
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 列出所有卖单
- (NSURLSessionTask *)yy_viewModelListOrdersWithPage:(NSInteger)page
                                            pageSize:(NSInteger)pageSize
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 列出我的买单  （接口暂时弃用）
- (NSURLSessionTask *)yy_viewModelListBuiesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure;

// 列出我的卖单 （接口暂时弃用）
- (NSURLSessionTask *)yy_viewModelListSalesWithPage:(NSInteger)page
                                           pageSize:(NSInteger)pageSize
                                            address:(NSString *)address
                                            success:(successBlock _Nullable)success
                                            failure:(failureBlock _Nullable)failure;

// 确认订单的完成情况
- (NSURLSessionTask *)yy_viewModelConfrimOrderWithAddress:(NSString *)address
                                                  orderId:(NSString *)orderId
                                                 password:(NSString *)password
                                                   status:(NSInteger)status
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;


@end

NS_ASSUME_NONNULL_END
