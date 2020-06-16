//
//  YYAlertView.h
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)(void);
typedef void(^cancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface YYAlertView : UIView

// 标题、内容、确认、取消
- (instancetype)initWithAttachView:(UIView *)attachView
                             title:(NSString *)title
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel;

// 内容、确认、取消
- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel;

// 内容、确认
- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                           confirm:(confirmBlock)confirm;

@end

NS_ASSUME_NONNULL_END
