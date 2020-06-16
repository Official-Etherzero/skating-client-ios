//
//  YYLoginHeaderView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLoginHeaderView.h"
#import "YYViewHeader.h"

@implementation YYLoginHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"etz_title"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_18);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_84, YYSIZE_33));
    }];
    
    YYButton *exitBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    exitBtn.stretchLength = 8.0f;
    [self addSubview:exitBtn];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_25);
        make.size.mas_offset(CGSizeMake(YYSIZE_18, YYSIZE_18));
    }];
    [exitBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)exitClick {
    if ([self.delegate respondsToSelector:@selector(yy_exitCurrentController)]) {
        [self.delegate yy_exitCurrentController];
    }
}

@end
