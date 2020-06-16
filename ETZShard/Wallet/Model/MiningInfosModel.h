//
//  MiningInfosModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiningInfosModel : NSObject

/**
 * double 类型后续统一使用 NSString 类型接收，再做转换操作
 */

@property (nonatomic, assign) NSInteger MiniID;   // 矿机 id
@property (nonatomic, assign) NSInteger MType;    // 矿机类型 1-初级，2-中级，3-高级， 4-顶级，5-特级，6-智能",
@property (nonatomic,   copy) NSString  *Name;    // 矿机名称",
@property (nonatomic, assign) NSInteger Type;     // 目前固定为1，表示矿机，方便后面扩展
@property (nonatomic, assign) NSInteger Input;    // 投入
@property (nonatomic, assign) NSInteger Earnings; // 收益
@property (nonatomic, assign) NSInteger Hashrate; // 算力
@property (nonatomic,   copy) NSString  *Ret;     // 每日产出(这里本来是 double 类型，但是数据类型转换会出现问题)
@property (nonatomic, assign) NSInteger Cycle;    // 周期
@property (nonatomic, assign) NSInteger Limit;    // 今日剩余
@property (nonatomic,   copy) NSString  *Remark;  // 备注

@end


NS_ASSUME_NONNULL_END
