//
//  YYEnum.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYEnum.h"
#import "YYLanguageTool.h"

@implementation YYEnum

NSString *yyGetValidateCodeString(ValidateMode status) {
    switch (status) {
        case VALIDATE_MODE_GOOGLE:
            return YYStringWithKey(@"谷歌验证码");
        case VALIDATE_MODE_MOBILE:
            return YYStringWithKey(@"手机验证码");
        case VALIDATE_MODE_EMAIL:
            return YYStringWithKey(@"邮箱验证码");
    }
    return @"";
}

// 矿机类型 1-初级，2-中级，3-高级， 4-顶级，5-特级，6-智能",
NSString *yyGetMiningMachineTypeString(MiningMachineType type) {
    switch (type) {
        case MINING_MACHINE_PRIMARY:
            return YYStringWithKey(@"初级机器人");
            break;
        case MINING_MACHINE_INTERMEDIATE:
            return YYStringWithKey(@"中级机器人");
            break;
        case MINING_MACHINE_ADVANCED:
            return YYStringWithKey(@"高级机器人");
            break;
        case MINING_MACHINE_TOP:
            return YYStringWithKey(@"顶级机器人");
            break;
        case MINING_MACHINE_SUPER:
            return YYStringWithKey(@"特级机器人");
            break;
        case MINING_MACHINE_INTELLIGENT:
            return YYStringWithKey(@"智能机器人");
            break;
            
        default:
            break;
    }
    return @"";
}

NSString *yyGetOrderStatusString(OrderStatus status) {
    switch (status) {
        case ORDER_PROCESSING:
            return YYStringWithKey(@"进行中");
            break;
        case ORDER_COMPLETE:
            return YYStringWithKey(@"已完成");
            break;
        case ORDER_CANCEL:
            return YYStringWithKey(@"已取消");
            break;
        default:
            break;
    }
}

NSString *yyGetAccountTypeString(AccountType type) {
    switch (type) {
        case ACCOUNT_TRANSFER:
            return YYStringWithKey(@"交易账户");
            break;
        case ACCOUNT_ROBOT:
            return YYStringWithKey(@"机器人账户");
            break;
        case ACCOUNT_WALLET:
            return YYStringWithKey(@"钱包账户");
            break;
        default:
            break;
    }
}

NSString *yyGetNodeTypeString(NodeType type) {
    switch (type) {
        case NODE_EXPERIENCE:
            return @"chuji";
            break;
        case NODE_NOVICE:
            return @"tiyan_node";
            break;
        case NODE_PRIMARY:
            return @"chuji";
            break;
        case NODE_INTERMEDIATE:
            return @"zhongji";
            break;
        case NODE_SENIOR:
            return @"gaoji";
            break;
        default:
            return @"chuji";
            break;
    }
}

NSString *yyGetNodeMiniIdString(NodeMiniId type) {
    switch (type) {
        case NODE_MINIID_EXPERIENCE:
            return YYStringWithKey(@"体验节点");
            break;
        case NODE_MINIID_NOVICE:
            return YYStringWithKey(@"新手节点");
            break;
        case NODE_MINIID_PRIMARY:
            return YYStringWithKey(@"初级节点");
            break;
        case NODE_MINIID_INTERMEDIATE:
            return YYStringWithKey(@"中级节点");
            break;
        case NODE_MINIID_SENIOR:
            return YYStringWithKey(@"高级节点");
            break;
        default:
            return YYStringWithKey(@"体验节点");
            break;
    }
}


@end
