//
//  YYAddNodeView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYAddNodeView.h"
#import "YYViewHeader.h"

@implementation YYAddNodeView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"zengjia"];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        YYLabel *addView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ffffff text:YYStringWithKey(@"增加节点")];
        addView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:addView];
        [addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}
@end
