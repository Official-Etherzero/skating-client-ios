//
//  APIMacro.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#ifndef APIMacro_h
#define APIMacro_h

// type 注册、登录、修改密码、忘记密码、绑定手机
static NSString *const kTypeRegister = @"register";
static NSString *const kTypelogin = @"login";
static NSString *const kTypeForgetsignpwd = @"forgetsignpwd";
static NSString *const kTypeUpdatesignpwd = @"updatesignpwd";
static NSString *const kTypeBindmobile = @"bindmobile";

// 注册
#define RegisterUrl         @"ubi/account/register"

// 用户是否注册
#define WhetherRegister     @"ubi/account/isRegister"

// 查询用户余额
#define UserBalance         @"ubi/account/assets"

// 划转 UBI
#define TransferUBI         @"ubi/account/transform"

// 提现 交易账户到钱包
#define WithdrawalUBI       @"ubi/account/withdraw"

// 所有和我相关的订单
#define ListMyOrders        @"ubi/otc/listMyOrders"

// 矿机
// 查询矿机可购买数量
#define QueryMinersNumber   @"ubi/mining/miningInfo"

// 矿机购买接口
#define BuyMiner            @"ubi/mining/miningPay"

// 正在运行的机器人列表
#define RunningRobots       @"ubi/mining/getUserMiningList"

// 机器人收益列表
#define RobotBenefits       @"ubi/mining/getMiningEarningList"

// 查询矿机算力统计信息
#define QueryMiningPower    @"ubi/mining/miningHashrate"

// 矿机购买记录列表
#define MinerPurchaseList   @"ubi/mining/getUserMiningBuyList"

// 奖励记录
#define RewardRecordList    @"ubi/mining/getMiningAwardList"

// 卖单
// 创建出售 UBI 的订单
#define Sale_CreateSale     @"ubi/otc/createSale"

// 设置 USDT 地址
#define Sale_SetUSDTAddress @"ubi/otc/SetUSDTAddr"

// OTC 详情
#define Sale_GetOTCInfo     @"ubi/otc/GetInfo"

// 取消出售 UBI
#define Sale_SaleCancel     @"ubi/otc/salecancel"

// 查看卖单详情
#define Sale_SaleDetail     @"ubi/otc/detail"

// 确认购买
#define Sale_ConfirmBuy     @"ubi/otc/confirmbuy"

// 取消购买
#define Sale_CancelBuy      @"ubi/otc/cancelbuy"

// 填写 hash
#define Sale_SetHash        @"ubi/otc/sethash"

// 列出所有卖单
#define Sale_ListOrders     @"ubi/otc/listOrders"

// 列出我的买单
#define Sale_ListBuies      @"ubi/otc/listMyBuys"

// 列出我的卖单
#define Sale_ListSales      @"ubi/otc/listMySales"

// 确认订单的完成情况
#define Sale_ConfirmOrder   @"ubi/otc/confirmSuccess"


// 买单
// 创建买入的 UBI 订单
#define Buy_CreateBuy       @"ubi/otc2/createbuy"

// 创建者取消自己创建的订单
#define Buy_CancelBuy       @"ubi/otc2/CancelBuy"

// 查看买单详情
#define Buy_BuyDetail       @"ubi/otc2/detail"

// 确定想要买入
#define Buy_ConfrimBuy      @"ubi/otc2/confirmSale"

// 确定不想买入
#define Buy_UnConfrimBuy    @"ubi/otc2/unConfirmSale"

// 填写 hash
#define Buy_SetHash         @"ubi/otc2/sethash"

// 确认交易结果
#define Buy_ConfirmOrder    @"ubi/otc2/confirmSuccess"

// 列出所有订单
#define Buy_ListOrders      @"ubi/otc2/listOrders"

// 列出我的所有买单
#define Buy_ListBuies       @"ubi/otc2/listMyBuys"

// 列出我的所有卖单
#define Buy_ListSales       @"ubi/otc2/listMySales"

// add marco 节点接口
// 节点列表
#define KNodeList        @"ubi/mining/getNodeList"
// 购买节点
#define KBuyNode         @"ubi/mining/buyNode"
// 领取免费节点
#define KFreeNode        @"ubi/mining/buyFreeNode"
// 我的节点列表
#define KMyNodeList      @"ubi/mining/getMyNodeList"
// 节点收益记录列表
#define KNodeRewardList  @"ubi/mining/getNodeRewardList"
// 团队收益记录列表
#define KTeamRewardList  @"ubi/mining/getTeamRewardList"
// 团队节点列表
#define KTeamNodeList    @"ubi/mining/getTeamNodeList"
// 提前释放节点
#define KReleaseNode     @"ubi/mining/releaseNode"
// 收益详情
#define KRewardDetail    @"ubi/mining/getDetailedList"

// 用户接口
// 手机注册
#define KPhoneRegister   @"ubi/account/registerByPhone"
// 邮箱注册
#define KMailRegister    @"ubi/account/registerByMail"
// 获取短信验证码
#define KGetSMSCode      @"ubi/account/getSMSCode"
// 获取邮件验证码
#define KGetEmailCode    @"ubi/account/getMailCode"
// 验证短信验证码
#define KVerifySMSCode   @"ubi/account/verifySMSCode"
// 验证邮件验证码
#define KVerifyMailCode  @"ubi/account/verifyMailCode"
// 用手机号登陆
#define KPhoneLogin      @"ubi/account/loginByPhone"
// 用邮箱号登陆
#define KMailLogin       @"ubi/account/loginByMail"
// 用户信息
#define KGetUserInfo     @"ubi/account/getUserInfo"
// 提现
#define KWithdraw        @"ubi/account/withdraw"
// 提交实名认证资料
#define KRealName        @"ubi/account/realNameProfile"
// 审核实名认证
#define KRealNameCheck   @"ubi/account/realNameCheck"
// 重置密码（手机）
#define KResetPhonePSW   @"ubi/account/retsetPWDbyPhone"
// 重置密码（邮箱）
#define KResetMailPSW    @"ubi/account/retsetPWDbyMail"
// 绑定钱包地址
#define KBindWallet      @"ubi/account/bindWallet"
// 签到
#define KSignIn          @"ubi/account/signin"
// 获取实名验证 token
#define KVerifyToken     @"ubi/account/AliDescribeVerifyToken"
// 查询实名结果
#define KVerifyResult    @"ubi/account/AliDescribeVerifyResult"


#endif /* APIMacro_h */
