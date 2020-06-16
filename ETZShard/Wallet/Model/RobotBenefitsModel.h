//
//  RobotBenefitsModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MinerIncomeModel : NSObject

/**
 @Parm
 OrderID 订单ID
 UserID  用户ID
 MiniID  矿机ID
 Ret     每日收益
 RetDate 收益日期
 Total   总记录条数
 TotalEarning 此矿机总收益
 */

@property (nonatomic, assign) NSInteger OrderID;
@property (nonatomic, assign) NSInteger UserID;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) double    Ret;
@property (nonatomic,   copy) NSString  *RetDate;

@end

@class MinerIncomeModel;
@interface RobotBenefitsModel : NSObject

@property (nonatomic, assign) NSInteger Total;
@property (nonatomic, assign) double    TotalEarning;
@property (nonatomic,   copy) NSArray<MinerIncomeModel *> *MiningEarningList;

@end

NS_ASSUME_NONNULL_END
