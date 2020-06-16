//
//  RobotMoreFunctionView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotMoreFunctionView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>

@implementation RobotMoreFunctionView

- (instancetype)initWithIcons:(NSArray *)icons titles:(NSArray *)titles {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.backgroundColor = COLOR_000000_A05;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = COLOR_ffffff;
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 5.0f;
        bottomView.clipsToBounds = YES;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_X_orMore) {
                make.top.mas_equalTo(self.mas_top).offset(YYSIZE_70);
            } else {
                make.top.mas_equalTo(self.mas_top).offset(YYSIZE_50);
            }
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_182));
        }];
        YYButton *lastView = nil;
        for (int i = 0; i < icons.count; i ++) {
            NSString *_t = titles[i];
            NSString *_icon = icons[i];
            YYButton *btn = [YYButton buttonWithType:UIButtonTypeCustom];
            btn.stretchLength = 20.0f;
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:_icon] forState:UIControlStateNormal];
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(YYSIZE_40);
                } else {
                    make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_28);
                }
                make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_16);
                make.size.mas_offset(CGSizeMake(YYSIZE_15, YYSIZE_15));
            }];
            WDWeakify(self);
            [btn bk_addEventHandler:^(id  _Nonnull sender) {
                WDStrongify(self);
                if (self.selectedTagBlock) {
                    self.selectedTagBlock(btn.tag);
                }
            } forControlEvents:UIControlEventTouchUpInside];
            lastView = btn;
            
            YYLabel *label = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_1a1a1a text:YYStringWithKey(_t)];
            label.textAlignment = NSTextAlignmentLeft;
            [bottomView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.mas_right).offset(YYSIZE_12);
                make.centerY.mas_equalTo(btn.mas_centerY);
            }];
        }
    }
    return self;
}

@end
