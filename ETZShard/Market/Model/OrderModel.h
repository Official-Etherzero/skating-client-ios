//
//  OrderModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

/**
 *@Parm
 "OrderID": "string",
 "UserID": "integer",
 "UBI": "decimal",
 "Price": "decimal",
 "Status": "integer",
 "USDTAddr": "string",
 "CustomID": "string",
 "WriteTime": "date-time",
 "LockTime": "string",
 "Hash": "string",
 "UBIWallet": "string"
 0表示新创建的，1表示锁定（等待买家确认，1分钟），2表示锁定（买家确认，等待付款，15分钟），3表示买家已经提交HASH等待卖家确认（60分钟），4表示交易完成，5表示交易不成功没收到USDT，6表示已取消 ,
 */

@property (nonatomic,   copy) NSString  *OrderID;
@property (nonatomic, assign) NSInteger UserID;
@property (nonatomic, assign) float     UBI;
@property (nonatomic, assign) float     Price;
@property (nonatomic, assign) NSInteger Status;
@property (nonatomic,   copy) NSString  *USDTAddr;
@property (nonatomic,   copy) NSString  *CustomID;
@property (nonatomic,   copy) NSString  *WriteTime;
@property (nonatomic,   copy) NSString  *LockTime;
@property (nonatomic,   copy) NSString  *Hash;
@property (nonatomic,   copy) NSString  *UBIWallet;
@property (nonatomic, assign) NSInteger direction;   // 1 卖单 2 买单


@end

NS_ASSUME_NONNULL_END
