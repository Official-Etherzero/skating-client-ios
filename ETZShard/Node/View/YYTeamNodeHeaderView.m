//
//  YYTeamNodeHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTeamNodeHeaderView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface YYTeamNodeHeaderView ()

@property (nonatomic, strong) YYLabel *totalRewardView;
@property (nonatomic, strong) YYLabel *numberView;
@property (nonatomic, strong) YYLabel *nodesView;
@property (nonatomic, strong) YYLabel *lastRewardView;
@property (nonatomic, strong) YYLabel *recommendDetailView;

@end

@implementation YYTeamNodeHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *bottomView = [[UIImageView alloc] init];
    bottomView.image = [UIImage imageNamed:@"tuanduijiedian"];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"总奖励 (ETZ)")];
    [self addSubview:titleView];
    titleView.textAlignment = NSTextAlignmentCenter;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_18);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYButton *detailView = [[YYButton alloc] initWithFont:FONT_DESIGN_24 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:YES title:YYStringWithKey(@"奖励明细") titleColor:COLOR_ffffff backgroundColor:COLOR_ffffff_A01 cornerRadius:12.5];
    [self addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_10);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_30);
        make.size.mas_offset(CGSizeMake(75, 25));
    }];
    WDWeakify(self);
    [detailView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.rewardDetailBlock) {
            self.rewardDetailBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.totalRewardView = [[YYLabel alloc] initWithFont:FONT_DESIGN_70 textColor:COLOR_ffffff text:@"20000"];
    self.totalRewardView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.totalRewardView];
    [self.totalRewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_45);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYLabel *numTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"团队人数")];
    [self addSubview:numTitleView];
    [numTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_36);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_100);
    }];
    
    self.numberView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"30"];
    [self addSubview:self.numberView];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(numTitleView.mas_centerX);
    }];
    
    YYLabel *recommandTitleView =  [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"有效/直推")];
    [self addSubview:recommandTitleView];
    [recommandTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).mas_offset(-YYSIZE_12);
        make.top.mas_equalTo(numTitleView.mas_top);
    }];
    
    self.recommendDetailView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"1000"];
    [self addSubview:self.recommendDetailView];
    [self.recommendDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(recommandTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(recommandTitleView.mas_centerX);
    }];

    
    YYLabel *nodesTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"锁币总数")];
    [self addSubview:nodesTitleView];
    [nodesTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(YYSIZE_12);
        make.top.mas_equalTo(numTitleView.mas_top);
    }];
    
    self.nodesView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"1000"];
    [self addSubview:self.nodesView];
    [self.nodesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nodesTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(nodesTitleView.mas_centerX);
    }];
    
    YYLabel *lastRewardTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_ffffff_A06 text:YYStringWithKey(@"昨日奖励")];
    [self addSubview:lastRewardTitleView];
    [lastRewardTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_36);
        make.top.mas_equalTo(numTitleView.mas_top);
    }];
    
    self.lastRewardView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:@"10000"];
    [self addSubview:self.lastRewardView];
    [self.lastRewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastRewardTitleView.mas_bottom).offset(YYSIZE_05);
        make.centerX.mas_equalTo(lastRewardTitleView.mas_centerX);
    }];
}

- (void)setModel:(TeamNodeModel *)model {
    self.totalRewardView.text = model.TeamReward;
    self.numberView.text = [NSString stringWithFormat:@"%ld",(long)model.PeopleCount];
    self.nodesView.text = [NSString stringWithFormat:@"%ld",(long)model.TeamNodeAmount];
    self.lastRewardView.text = model.RewardYesterday;
    self.recommendDetailView.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.PeopleCount,(long)model.PeopleCount2];
}

@end
