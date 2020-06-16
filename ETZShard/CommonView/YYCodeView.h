//
//  YYCodeView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEnum.h"
#import "YYPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SendMessageCodeBlock)();

@interface YYCodeView : UIView

@property (nonatomic, strong) YYPlaceholderView     *plcView;
@property (nonatomic,   copy) SendMessageCodeBlock  sendCodeBlock;

- (instancetype)initCodeViewWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
