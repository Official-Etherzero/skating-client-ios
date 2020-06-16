//
//  YYMessageView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEnum.h"
#import "CodeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MessageBlock)(NSArray *codes);
typedef void(^HideBlock)(void);
typedef void(^SendCodeBlock)(NSInteger code);


@interface YYMessageView : UIView

@property (nonatomic,  copy) MessageBlock   messageBlock;
@property (nonatomic,  copy) HideBlock      hideBlock;
@property (nonatomic,  copy) SendCodeBlock  sendCodeBlock;

- (instancetype)initMessageViewWithModelist:(NSArray *)list;


@end

NS_ASSUME_NONNULL_END
