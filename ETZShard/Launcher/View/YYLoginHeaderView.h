//
//  YYLoginHeaderView.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYLoginHeaderViewDelegate <NSObject>

- (void)yy_exitCurrentController;

@end

@interface YYLoginHeaderView : UIView

@property (nonatomic,  weak) id<YYLoginHeaderViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
