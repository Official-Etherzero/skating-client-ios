//
//  YYNodeHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeHeaderView.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface YYNodeHeaderView ()

@property (nonatomic, strong) YYLabel *headerView;

@end

@implementation YYNodeHeaderView

- (instancetype)init {
    if (self = [super init]) {
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"jiedian"];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        self.headerView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_72 textColor:COLOR_ffffff text:@"0.0000"];
        [self addSubview:self.headerView];
        self.headerView.textAlignment = NSTextAlignmentRight;
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_50);
            make.centerX.mas_equalTo(self.mas_centerX).offset(-YYSIZE_22);
        }];
        
        YYLabel *unitView = [[YYLabel alloc] initWithFont:FONT_DESIGN_36 textColor:COLOR_ffffff text:@"ETZ"];
        [self addSubview:unitView];
        unitView.textAlignment = NSTextAlignmentLeft;
        [unitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_70);
            make.left.mas_equalTo(self.headerView.mas_right).offset(YYSIZE_06);
        }];
        
        YYButton *chargeView = [[YYButton alloc] initWithFont:FONT_DESIGN_28 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:YES title:YYStringWithKey(@"充值") titleColor:COLOR_ffffff backgroundColor:COLOR_ffffff_A01 cornerRadius:YYSIZE_15];
        [self addSubview:chargeView];
        chargeView.stretchLength = 10.0f;
        [chargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-YYSIZE_20);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_56);
            make.size.mas_offset(CGSizeMake(YYSIZE_90, YYSIZE_30));
        }];
        
        WDWeakify(self);
        [chargeView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.chargeBlock) {
                self.chargeBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *withdrawalView = [[YYButton alloc] initWithFont:FONT_DESIGN_28 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:YES title:YYStringWithKey(@"提现") titleColor:COLOR_ffffff backgroundColor:COLOR_ffffff_A01 cornerRadius:YYSIZE_15];
        [self addSubview:withdrawalView];
        withdrawalView.stretchLength = 10.0f;
        [withdrawalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(chargeView.mas_bottom);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_56);
            make.size.mas_offset(CGSizeMake(YYSIZE_90, YYSIZE_30));
        }];
        
        [withdrawalView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.withdrawalBlock) {
                self.withdrawalBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *detailView = [[YYButton alloc] initWithFont:FONT_DESIGN_28 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:YES title:YYStringWithKey(@"充提明细") titleColor:COLOR_ffffff backgroundColor:COLOR_ffffff_A01 cornerRadius:YYSIZE_15];
        [self addSubview:detailView];
        detailView.stretchLength = 10.0f;
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_20);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_90, YYSIZE_30));
        }];
        [detailView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.detailBlock) {
                self.detailBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setBalnace:(NSString *)balnace {
    self.headerView.text = [balnace yy_holdDecimalPlaceToIndex:4];
}



@end
