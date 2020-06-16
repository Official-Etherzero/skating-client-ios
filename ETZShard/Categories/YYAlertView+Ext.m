//
//  YYAlertView+Ext.m
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYAlertView+Ext.h"

@implementation YYAlertView (Ext)

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                      title:(NSString *)title
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                cancelTitle:(NSString *)cancelTitle
                                    confirm:(confirmBlock)confirm
                                     cancel:(cancelBlock)cancel {
    YYAlertView *alertView = [[YYAlertView alloc] initWithAttachView:attachView title:title describe:describe comfirmTitle:comfirmTitle cancelTitle:cancelTitle confirm:confirm cancel:cancel];
    return alertView;
}

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                cancelTitle:(NSString *)cancelTitle
                                    confirm:(confirmBlock)confirm
                                     cancel:(cancelBlock)cancel {
    YYAlertView *alertView = [[YYAlertView alloc] initWithAttachView:attachView describe:describe comfirmTitle:comfirmTitle cancelTitle:cancelTitle confirm:confirm cancel:cancel];
    return alertView;
}

+ (instancetype)showAlertViewWithAttachView:(UIView *)attachView
                                   describe:(NSString *)describe
                               comfirmTitle:(NSString *)comfirmTitle
                                    confirm:(confirmBlock)confirm {
    YYAlertView *alertView = [[YYAlertView alloc] initWithAttachView:attachView describe:describe comfirmTitle:comfirmTitle confirm:confirm];
    return alertView;
}

@end
