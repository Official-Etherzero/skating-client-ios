//
//  MessageView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/30.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfimBlock)(NSString *codeStr);
typedef void(^SendBlock)(void);

@interface MessageView : UIView

+ (instancetype)showMessageViewTitle:(NSString *)title
                           SendBlock:(SendBlock)sendBlock
                        confirmBlock:(ConfimBlock)confimBlock;

@end

NS_ASSUME_NONNULL_END
