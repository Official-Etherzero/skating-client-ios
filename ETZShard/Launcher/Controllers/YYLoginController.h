//
//  YYLoginController.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/19.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "WDBaseFunctionController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginStatusBlock)(void);
typedef void(^DismissBlock)(void);

@interface YYLoginController : WDBaseFunctionController

@property (nonatomic, copy) LoginStatusBlock loginBlock;
@property (nonatomic, copy) DismissBlock     dismissBlock;

- (instancetype)initLoginViewController;

@end

NS_ASSUME_NONNULL_END
