//
//  MessageView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/30.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "MessageView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYCodeView.h"

@interface MessageView ()

@property (nonatomic,   copy) SendBlock   sendBlock;
@property (nonatomic,   copy) ConfimBlock confimBlock;
@property (nonatomic,   copy) NSString    *title;
@property (nonatomic, strong) YYCodeView  *codeView;

@end

@implementation MessageView

+ (instancetype)showMessageViewTitle:(NSString *)title
                           SendBlock:(SendBlock)sendBlock
                        confirmBlock:(ConfimBlock)confimBlock{
    MessageView *view = [[MessageView alloc] init];
    view.confimBlock = confimBlock;
    view.sendBlock = sendBlock;
    view.title = title;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_ffffff;
        CGFloat viewHeight = YYSIZE_45 + YYSIZE_85 + YYSIZE_74;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.mas_bottom);
            }
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, viewHeight));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_090814 text:YYStringWithKey(@"安全验证")];
        [titleView yy_setWordSpace:0];
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_80, YYSIZE_15));
        }];
        
        YYButton *rightView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 title:YYStringWithKey(@"取消") titleColor:COLOR_090814_A05];
        [rightView.titleLabel yy_setWordSpace:0];
        rightView.stretchLength = 10.0f;
        [bottomView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleView.mas_centerY);
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_25);
            make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_13));
        }];
        WDWeakify(self);
        [rightView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
    
        self.codeView = [[YYCodeView alloc] initCodeViewWithTitle:YYStringWithKey(self.title)];
        [bottomView addSubview:self.codeView];
        [self.codeView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_10);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_74));
        }];
        self.codeView.sendCodeBlock = ^{
            WDStrongify(self);
            if (self.sendBlock) {
                self.sendBlock();
            }
        };
        
        YYButton *confrimView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_7a6cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确定") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
        [bottomView addSubview:confrimView];
        [confrimView yy_setGradientColors:@[(__bridge id)COLOR_ffca46.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
        [confrimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-YYSIZE_20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_325, YYSIZE_45));
        }];
        [confrimView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (!(self.codeView.plcView.content && self.codeView.plcView.content.length > 0)) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入验证码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (self.confimBlock) {
                self.confimBlock(self.codeView.plcView.content);
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
