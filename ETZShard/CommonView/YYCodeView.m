//
//  YYCodeView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYCodeView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"
#import "YYGCDTimer.h"

@interface YYCodeView ()

@property (nonatomic, strong) YYLabel   *timeView;
@property (nonatomic, strong) YYButton  *pasteView;
@property (nonatomic,   copy) NSString  *gcdTimer;
@property (nonatomic, assign) NSInteger currentCount;

@end

@implementation YYCodeView

- (instancetype)initCodeViewWithTitle:(NSString *)title {
    if (self = [super init]) {
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = COLOR_090814_A008;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_25);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH - YYSIZE_50, 0.5));
        }];
        
        YYPlaceholderView *plcView = [[YYPlaceholderView alloc] initPlaceholderViewWithFont:FONT_PingFangSC_Medium_26 plcStr:YYStringWithKey(title) leftMargin:YYSIZE_25];
        [self addSubview:plcView];
        [plcView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(line.mas_top);
            make.left.right.mas_equalTo(self);
            make.height.mas_offset(YYSIZE_40);
        }];
        self.plcView = plcView;
        
        YYButton *pasteView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"获取验证码") titleColor:COLOR_5d4fe0];
        [pasteView.titleLabel yy_setWordSpace:0];
        pasteView.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:pasteView];
        [pasteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_25);
            make.centerY.mas_equalTo(plcView.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_80, YYSIZE_13));
        }];
        WDWeakify(self);
        [pasteView bk_addEventHandler:^(id  _Nonnull sender) {
            // 获取验证码
            WDStrongify(self);
            if (self.sendCodeBlock) {
                self.sendCodeBlock();
            }
            [self handleVerificateCodeClick];
        } forControlEvents:UIControlEventTouchUpInside];
        self.pasteView = pasteView;
        
        // 375 * 74  左右边距 25
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_090814 text:YYStringWithKey(title)];
        [self addSubview:titleView];
        titleView.textAlignment = NSTextAlignmentLeft;
        [titleView yy_setWordSpace:0];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(plcView.mas_top).offset(-YYSIZE_08);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_30);
            make.size.mas_offset(CGSizeMake(YYSIZE_100, YYSIZE_13));
        }];
        
        self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_5d4fe0 text:@"60s"];
        [self addSubview:self.timeView];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(pasteView.mas_centerY).offset(YYSIZE_05);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_12));
        }];
        self.timeView.hidden = YES;
    }
    return self;
}

- (void)handleVerificateCodeClick {
    self.pasteView.hidden = YES;
    self.timeView.hidden = NO;
    self.currentCount = 60;
    self.gcdTimer = [YYGCDTimer timerTask:self selector:@selector(openFire) start:0 interval:1.0f repeats:YES async:YES];
}

-(void)openFire {
    if (self.currentCount == 1) {
        [YYGCDTimer canelTimer:self.gcdTimer];
        dispatch_async_main_safe(^{
            self.pasteView.hidden = NO;
            self.timeView.hidden = YES;
        });
        return;
    }
    self.currentCount --;
    dispatch_async_main_safe((^{
        self.timeView.text = [NSString stringWithFormat:@"%lds",(long)self.currentCount];
    }));
}

@end
