//
//  YYLoginBottomView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLoginBottomView.h"
#import "YYViewHeader.h"

@implementation YYLoginBottomView

- (instancetype)initWithTitle:(NSString *)title des:(NSString *)des {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        YYLabel *label = [YYLabel new];
        [self addSubview:label];
        label.text = title;
        [label setFont:FONT_DESIGN_30];
        label.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        label.textAlignment = NSTextAlignmentRight;
        [label setTextColor:COLOR_090814_A03];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(self);
            make.width.mas_offset(YYSIZE_80);
        }];
        
        YYButton *button = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:NO title:des titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff cornerRadius:0];
        button.stretchLength = 16.0f;
        [self addSubview:button];
        [button addTarget:self action:@selector(vcClick:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(label.mas_right).offset(-YYSIZE_08);
            make.width.mas_offset(YYSIZE_80);
        }];
    }
    return self;
}

- (void)vcClick:(UIButton *)btn {
    if ([self.delegate performSelector:@selector(yy_showRegisterLoginView)]) {
        [self.delegate yy_showRegisterLoginView];
    }
}


@end
