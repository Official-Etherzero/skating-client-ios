//
//  CodeModel.h
//  ExchangeClientForIOS
//
//  Created by yang on 2020/1/14.
//  Copyright © 2020 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeModel : NSObject

@property (nonatomic, assign) NSInteger  codeType;     // 验证码类型
@property (nonatomic,   copy) NSString   *codeString;  // 验证码

@end

NS_ASSUME_NONNULL_END
