//
//  RobotBottomView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotBottomView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@implementation RobotBottomView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        UIView *leftView = [[UIView alloc] init];
        [self addSubview:leftView];
        leftView.backgroundColor = COLOR_3d5afe;
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_31);
            make.size.mas_offset(CGSizeMake(YYSIZE_04, YYSIZE_19));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_44 textColor:COLOR_1a1a1a text:title];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.centerY.mas_equalTo(leftView.mas_centerY);
        }];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    leftView.backgroundColor = COLOR_3d5afe;
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_31);
        make.size.mas_offset(CGSizeMake(YYSIZE_04, YYSIZE_19));
    }];
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_44 textColor:COLOR_1a1a1a text:YYStringWithKey(@"正在运行的机器人")];
    titleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.centerY.mas_equalTo(leftView.mas_centerY);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"robot_dis"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_50);
        make.size.mas_offset(CGSizeMake(YYSIZE_90, YYSIZE_90));
    }];
    
    YYLabel *centerView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_1a1a1a text:YYStringWithKey(@"您还没有机器人")];
    centerView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYButton *addView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"立即购买") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    addView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:addView];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_52);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_130, YYSIZE_40));
    }];
    WDWeakify(self);
    [addView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.addMinerBlock) {
            self.addMinerBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}


@end
