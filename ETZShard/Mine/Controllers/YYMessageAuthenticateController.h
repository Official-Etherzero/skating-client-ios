//
//  YYMessageAuthenticateController.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "CodeModel.h"
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HandleCodeBlock)(NSArray *codes);

@interface YYMessageAuthenticateController : WDBaseFunctionController

@property (nonatomic,   copy) HandleCodeBlock handeCodeBlock;

- (instancetype)initWithCodeTypes:(NSArray *)codeTypes;

@end

NS_ASSUME_NONNULL_END
