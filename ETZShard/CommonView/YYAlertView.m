//
//  YYAlertView.m
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYAlertView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>


@interface YYAlertView ()
@property(nonatomic, copy) confirmBlock confirmBlock;
@property(nonatomic, copy) cancelBlock  cancelBlock;

@end

@implementation YYAlertView

- (instancetype)initWithAttachView:(UIView *)attachView
                             title:(NSString *)title
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [attachView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(attachView);
        }];
        self.confirmBlock = confirm;
        self.cancelBlock = cancel;
        self.backgroundColor = COLOR_000000_A05;
        UIView *contentView = ({
            UIView *v = [[UIView alloc] init];
            [self addSubview:v];
            v.layer.cornerRadius = 4.0f;
            v.backgroundColor = COLOR_ffffff;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(YYSIZE_275, YYSIZE_158));
            }];
            v;
        });
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_30 textColor:COLOR_090814 text:title];
        titleView.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView).offset(YYSIZE_24);
            make.left.mas_equalTo(contentView).offset(YYSIZE_15);
            make.right.mas_equalTo(contentView).offset(-YYSIZE_15);
        }];
        
        YYLabel *describeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_090814 text:describe];
        describeView.numberOfLines = 0;
        describeView.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:describeView];
        [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_10);
            make.left.right.mas_equalTo(contentView);
        }];
        
        __weak typeof(self) weakSelf = self;
        YYButton *cancelButton = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:cancelTitle titleColor:COLOR_ffffff backgroundColor:COLOR_e3e3e6 cornerRadius:5.0f];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView);
            make.left.mas_equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_138, YYSIZE_42));
        }];
        
        [cancelButton bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf removeFromSuperview];
            if (weakSelf.cancelBlock) {
                weakSelf.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
       
        
        YYButton *confirmButton = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:comfirmTitle titleColor:COLOR_5d4fe0 backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
        [confirmButton yy_setGradientColors:@[(__bridge id)COLOR_7a6cff.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
        confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [confirmButton addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView);
            make.left.mas_equalTo(cancelButton.mas_right).offset(-1);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_138, YYSIZE_42));
        }];
        [confirmButton bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf removeFromSuperview];
            if (weakSelf.confirmBlock) {
                weakSelf.confirmBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [attachView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(attachView);
        }];
        self.confirmBlock = confirm;
        self.cancelBlock = cancel;
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *alertBgView = ({
            UIView *v = [[UIView alloc] init];
            [self addSubview:v];
            v.layer.cornerRadius = 10.0f;
            v.backgroundColor = COLOR_ffffff;
            v.clipsToBounds = YES;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(YYSIZE_275, YYSIZE_158));
            }];
            v;
        });
        
        YYButton *cancelButton = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:cancelTitle titleColor:COLOR_ffffff backgroundColor:COLOR_e3e3e6 cornerRadius:5.0f];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [alertBgView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(alertBgView);
            make.left.mas_equalTo(alertBgView);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_138, YYSIZE_42));
        }];
        
        YYButton *confirmButton = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:comfirmTitle titleColor:COLOR_5d4fe0 backgroundColor:COLOR_7a6cff cornerRadius:5.0f];
        [confirmButton yy_setGradientColors:@[(__bridge id)COLOR_7a6cff.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
        confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [confirmButton addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];

        [alertBgView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(alertBgView);
            make.left.mas_equalTo(cancelButton.mas_right).offset(-1);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_138, YYSIZE_42));
        }];
        
        YYLabel *describeView = [[YYLabel alloc] initWithFont:FONT_FZDHTJW_32 textColor:COLOR_090814 text:describe];
        describeView.numberOfLines = 0;
        describeView.textAlignment = NSTextAlignmentCenter;
        [alertBgView addSubview:describeView];
        [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(alertBgView.mas_top);
             make.size.mas_offset(CGSizeMake(YYSIZE_260, YYSIZE_100));
        }];
    }
    return self;
}

- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                           confirm:(confirmBlock)confirm {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [attachView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(attachView);
        }];
        self.confirmBlock = confirm;
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *contentView = ({
            UIView *v = [[UIView alloc] init];
            [self addSubview:v];
            v.layer.cornerRadius = 4.0f;
            v.backgroundColor = COLOR_ffffff;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(YYSIZE_275, YYSIZE_158));
            }];
            v;
        });
        
        __weak typeof(self) weakSelf = self;
        YYButton *confirmButton = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:1 borderColoer:COLOR_e3e3e6.CGColor masksToBounds:YES title:comfirmTitle titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:5.0f];
        [confirmButton yy_setGradientColors:@[(__bridge id)COLOR_7a6cff.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
        confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [confirmButton bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf removeFromSuperview];
            if (weakSelf.confirmBlock) {
                weakSelf.confirmBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView);
            make.centerX.mas_equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_275, YYSIZE_42));
        }];
        
//        UIView *line = [UIView new];
//        line.backgroundColor = COLOR_dfe1e6;
//        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(contentView);
//            make.bottom.mas_equalTo(confirmButton.mas_top);
//            make.height.mas_offset(YYSIZE_01);
//        }];
        
        YYLabel *describeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_4f4f4f text:describe];
        describeView.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:describeView];
        [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView).offset(YYSIZE_29);
            make.bottom.mas_equalTo(confirmButton.mas_top).offset(-YYSIZE_25);
            make.left.mas_equalTo(contentView).offset(YYSIZE_15);
            make.right.mas_equalTo(contentView).offset(-YYSIZE_15);
        }];
    }
    return self;
}

#pragma mark -  点击事件
- (void)sureBtnClick {
    [self removeFromSuperview];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)cancleBtnClick {
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
@end
