//
//  YYEnum.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, YYGradientDirectionType) {
    YYGradientDirectionLevel = 0,          //水平方向渐变
    YYGradientDirectionVertical = 1,       //垂直方向渐变
    YYGradientDirectionUpwardDiagonalLine, //主对角线方向渐变
    YYGradientDirectionDownDiagonalLine,   //副对角线方向渐变
};

typedef NS_ENUM(NSUInteger, OrderStatus) {
    ORDER_PROCESSING  = 1,
    ORDER_COMPLETE    = 2,
    ORDER_CANCEL      = 3,
};

typedef NS_ENUM(NSUInteger, AccountType) {
    ACCOUNT_TRANSFER   = 0,
    ACCOUNT_ROBOT      = 1,
    ACCOUNT_WALLET     = 2,
};

typedef NS_ENUM(NSUInteger, TransferType) {
    TRANSFER_TRA_WALLET    = 0,
    TRANSFER_TRA_ROBOT     = 1,
    TRANSFER_ROB_TRANSFER  = 2,
    TRANSFER_WAL_ROBOT     = 3,
};

typedef NS_ENUM(NSUInteger, MiningMachineType) {
    MINING_MACHINE_PRIMARY      = 1,
    MINING_MACHINE_INTERMEDIATE = 2,
    MINING_MACHINE_ADVANCED     = 3,
    MINING_MACHINE_TOP,
    MINING_MACHINE_SUPER,
    MINING_MACHINE_INTELLIGENT,
};

typedef NS_ENUM(NSUInteger, NodeType) {
    NODE_EXPERIENCE      = 1,
    NODE_NOVICE          = 2,
    NODE_PRIMARY         = 3,
    NODE_INTERMEDIATE    = 4,
    NODE_SENIOR          = 5,
};

typedef NS_ENUM(NSUInteger, NodeMiniId) {
    NODE_MINIID_EXPERIENCE      = 1,
    NODE_MINIID_NOVICE          = 2,
    NODE_MINIID_PRIMARY         = 3,
    NODE_MINIID_INTERMEDIATE    = 4,
    NODE_MINIID_SENIOR          = 5,
};

typedef NS_ENUM(NSUInteger, ValidateMode) {
    VALIDATE_MODE_GOOGLE = 0,
    VALIDATE_MODE_MOBILE = 1,
    VALIDATE_MODE_EMAIL ,
};

NSString *yyGetValidateCodeString(ValidateMode code);
NSString *yyGetMiningMachineTypeString(MiningMachineType code);
NSString *yyGetOrderStatusString(OrderStatus status);
NSString *yyGetAccountTypeString(AccountType type);
NSString *yyGetNodeTypeString(NodeType type);
NSString *yyGetNodeMiniIdString(NodeMiniId type);

@interface YYEnum : NSObject
@end

NS_ASSUME_NONNULL_END
