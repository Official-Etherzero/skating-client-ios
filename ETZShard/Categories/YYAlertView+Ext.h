//
//  YYAlertView+Ext.h
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYAlertView (Ext)

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                      title:(NSString *)title
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                cancelTitle:(NSString *)cancelTitle
                                    confirm:(confirmBlock)confirm
                                     cancel:(cancelBlock)cancel;

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                cancelTitle:(NSString *)cancelTitle
                                    confirm:(confirmBlock)confirm
                                     cancel:(cancelBlock)cancel;

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                    confirm:(confirmBlock)confirm;

@end

NS_ASSUME_NONNULL_END
