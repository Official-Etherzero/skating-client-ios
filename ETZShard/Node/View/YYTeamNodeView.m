//
//  YYTeamNodeView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTeamNodeView.h"
#import "YYViewHeader.h"

@interface YYTeamNodeView ()

@property (nonatomic, strong) YYLabel *dataView;
@property (nonatomic, strong) YYLabel *outPutView;

@end

@implementation YYTeamNodeView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"tuandui"];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:YYStringWithKey(@"团队节点")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleView];
        
        self.dataView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_60 textColor:COLOR_ffffff text:@"3"];
        self.dataView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dataView];
        
        self.outPutView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_ffffff text:YYStringWithKey(@"昨日奖励：100000 ETZ")];
        self.outPutView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.outPutView];
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_16);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_36);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self.outPutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-YYSIZE_26);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return self;
}

- (void)setModel:(TeamNodeModel *)model {
    self.dataView.text = [NSString stringWithFormat:@"%ld",(long)model.TeamNodeCount];
    self.outPutView.text = [NSString stringWithFormat:@"昨日奖励：%@ ETZ",model.TeamReward];
}

@end
