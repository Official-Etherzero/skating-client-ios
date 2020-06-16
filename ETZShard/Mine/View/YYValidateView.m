//
//  YYValidateView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/27.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYValidateView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@implementation YYValidateView

+ (instancetype)initAttachView:(UIView *)view
                        titles:(NSArray *)titles
                   googleBlock:(void (^)(void))googleBlock
                    phoneBlock:(void(^)(void))phoneBlock {
    YYValidateView *validateView =  [[YYValidateView alloc] initWithAttachView:view titles:titles googleBlock:googleBlock phoneBlock:phoneBlock];
    return validateView;
}

- (instancetype)initWithAttachView:(UIView *)view
                            titles:(NSArray *)titles
                       googleBlock:(void (^)(void))googleBlock
                        phoneBlock:(void(^)(void))phoneBlock  {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo([UIApplication sharedApplication].keyWindow.mas_centerX);
            make.centerY.mas_equalTo([UIApplication sharedApplication].keyWindow.mas_centerY).offset(-YYSIZE_100);
            make.size.mas_offset(CGSizeMake(YYSIZE_250, YYSIZE_180));
        }];
        
         __weak typeof(self) weakSelf = self;
        self.backgroundColor = COLOR_000000_A05;
        // 背景色
        UIView *backGroundView = [[UIView alloc] init];
        [self addSubview:backGroundView];
        backGroundView.backgroundColor = COLOR_ffffff;
        backGroundView.frame = self.bounds;
        backGroundView.clipsToBounds = YES;
        backGroundView.layer.cornerRadius = 5.0f;
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_090814 text:YYStringWithKey(@"温馨提示")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_22);
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_090814 text:YYStringWithKey(@"基于账号安全考虑，请开启二次验证")];
        contentView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_08);
        }];
        
        // 中间两个 button ，第一个是 谷歌， 第二个是 手机或者 邮箱
        YYButton *googleBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_24 borderWidth:0.5f borderColoer:COLOR_5d4fe0.CGColor masksToBounds:YES title:YYStringWithKey(titles.firstObject) titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:3.0f];
        googleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:googleBtn];
        [googleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_24);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_91);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_28));
        }];
        [googleBtn bk_addEventHandler:^(id  _Nonnull sender) {
            if (googleBlock) {
                googleBlock();
            }
            [weakSelf removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *phoneBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_24 borderWidth:0.5f borderColoer:COLOR_5d4fe0.CGColor masksToBounds:YES title:YYStringWithKey(titles.lastObject) titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:3.0f];
        phoneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(googleBtn.mas_right).offset(YYSIZE_20);
            make.top.mas_equalTo(googleBtn.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_28));
        }];
        [phoneBtn bk_addEventHandler:^(id  _Nonnull sender) {
            if (phoneBlock) {
                phoneBlock();
            }
            [weakSelf removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *privacyBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_24 title:YYStringWithKey(@"暂不开启，下回再通知我") titleColor:COLOR_5d4fe0];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:YYStringWithKey(@"暂不开启，下回再通知我") attributes:attribtDic];
        privacyBtn.titleLabel.attributedText = attribtStr;
        privacyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_140, YYSIZE_13));
        }];
        [privacyBtn bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
@end
