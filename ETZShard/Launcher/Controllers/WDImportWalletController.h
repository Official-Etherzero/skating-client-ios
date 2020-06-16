//
//  WDImportWalletController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBaseFunctionController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDImportWalletController : WDBaseFunctionController

- (instancetype)initBindWalletWithAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
