//
//  OrderDetailModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailModel : NSObject

/**
 "OrderID": "string",
 "UBI": "decimal",
 "Price": "decimal",
 "status": "integer",
 "USDTAddr": "string",
 "WriteTime": "date-time"
 */

@property (nonatomic,  copy) NSString  *OrderID;
@property (nonatomic,assign) float     UBI;
@property (nonatomic,assign) float     Price;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,  copy) NSString  *UBIOUT;
@property (nonatomic,  copy) NSString  *USDTAddr;
@property (nonatomic,  copy) NSString  *WriteTime;

@end

NS_ASSUME_NONNULL_END
