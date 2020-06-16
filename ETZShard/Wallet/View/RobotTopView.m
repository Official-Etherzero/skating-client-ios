//
//  RobotTopView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotTopView.h"
#import "YYViewHeader.h"
#import "RobotTitleView.h"
#import "NSString+Ext.h"

@interface RobotTopView ()
@property (nonatomic, strong) RobotTitleView *allHashrateView;
@property (nonatomic, strong) RobotTitleView *allNodesView;
@property (nonatomic, strong) RobotTitleView *myHashrateView;
@property (nonatomic, strong) RobotTitleView *teamHashrateView;
@property (nonatomic, strong) YYLabel        *balanceView;

@end

@implementation RobotTopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        
        UIImageView *cardView = [[UIImageView alloc] init];
        cardView.image = [UIImage imageNamed:@"robot_card"];
        [self addSubview:cardView];
        [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_10);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_70));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ebefff text:YYStringWithKey(@"机器人账户余额:")];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cardView.mas_left).offset(YYSIZE_12);
            make.centerY.mas_equalTo(cardView.mas_centerY);
        }];
        
        self.balanceView = [[YYLabel alloc] initWithFont:FONT_BEBAS_44 textColor:COLOR_ffffff text:@"0"];
        self.balanceView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.balanceView];
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cardView.mas_right).offset(-YYSIZE_12);
            make.centerY.mas_equalTo(cardView.mas_centerY);
        }];
        
        self.allHashrateView = [[RobotTitleView alloc] initWithLeftView:@"quanwangsuanli" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"全网算力")]];
        [self addSubview:self.allHashrateView];
        
        self.allNodesView = [[RobotTitleView alloc] initWithLeftView:@"quanwangjiedian" title:YYStringWithKey(@"全网节点(个)")];
        [self addSubview:self.allNodesView];
        
        self.myHashrateView = [[RobotTitleView alloc] initWithLeftView:@"wodesuanli" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"我的算力")]];
        [self addSubview:self.myHashrateView];
        
        self.teamHashrateView = [[RobotTitleView alloc] initWithLeftView:@"tuanduisuanli" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"团队算力")]];
        [self addSubview:self.teamHashrateView];
        
        [self.allHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(cardView.mas_bottom).offset(YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH/2, YYSIZE_35));
        }];
        
        [self.allNodesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.allHashrateView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH/2, YYSIZE_35));
        }];
        
        [self.myHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self.allHashrateView.mas_bottom).offset(YYSIZE_30);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH/2, YYSIZE_35));
        }];
        
        [self.teamHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.myHashrateView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH/2, YYSIZE_35));
        }];
    }
    return self;
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    self.balanceView.text = [balance yy_holdDecimalPlaceToIndex:4];
}

- (void)setModel:(CalculateStatisticalModel *)model {
    self.allHashrateView.content = [model.WHashrate yy_holdDecimalPlaceToIndex:2];
    self.allNodesView.content = [NSString stringWithFormat:@"%ld",(long)model.WNode];
    self.myHashrateView.content = [model.MHashrate yy_holdDecimalPlaceToIndex:2];
    self.teamHashrateView.content = [model.THashrate yy_holdDecimalPlaceToIndex:2];
}

@end
