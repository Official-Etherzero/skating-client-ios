//
//  YYInvitateView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYInvitateView.h"
#import "YYViewHeader.h"

@implementation YYInvitateView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"yaoqing_node"];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ffffff text:YYStringWithKey(@"邀请好友")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
//        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff text:YYStringWithKey(@"立减手续费5%")];
//        contentView.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:contentView];
//        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_08);
//        }];
    }
    return self;
}

@end
