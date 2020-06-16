//
//  YYCodeInputView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/10.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCodeInputView : UIView

@property (nonatomic, copy) NSString *content;

- (instancetype)initCodeInputViewWithTitle:(NSString *)title
                                    plcStr:(NSString *)plcStr;

@end

NS_ASSUME_NONNULL_END
