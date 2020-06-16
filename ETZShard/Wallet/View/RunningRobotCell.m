//
//  RunningRobotCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RunningRobotCell.h"
#import "YYViewHeader.h"
#import "YYDateModel.h"
#import "YYPercentView.h"

@interface RunningRobotCell ()

@property (nonatomic, strong) YYLabel  *titleView;
@property (nonatomic, strong) YYLabel  *startView;
@property (nonatomic, strong) YYLabel  *endView;
@property (nonatomic, strong) YYPercentView *percentView;

@end

@implementation RunningRobotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = COLOR_ffffff;
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_10);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_100));
        }];
        bottomView.layer.shadowColor = [UIColor colorWithRed:210/255.0 green:212/255.0 blue:217/255.0 alpha:0.3].CGColor;
        bottomView.layer.shadowOffset = CGSizeMake(0,5);
        bottomView.layer.shadowOpacity = 1;
        bottomView.layer.shadowRadius = 10;
        bottomView.layer.cornerRadius = 5;
        
        self.titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_1a1a1a text:@""];
        self.titleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_12);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        }];
        
        YYLabel *startTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"启动日期")];
        startTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:startTitleView];
        [startTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        self.startView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:@""];
        self.startView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:self.startView];
        [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(startTitleView.mas_right).offset(YYSIZE_16);
            make.top.mas_equalTo(startTitleView.mas_top);
        }];
        
        YYLabel *endTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:YYStringWithKey(@"到期日期")];
        endTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:endTitleView];
        [endTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(startTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        self.endView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_1a1a1a_A06 text:@""];
        self.endView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:self.endView];
        [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(endTitleView.mas_right).offset(YYSIZE_16);
            make.top.mas_equalTo(endTitleView.mas_top);
        }];
        
        self.percentView = [[YYPercentView alloc] init];
        [bottomView addSubview:self.percentView];
        [self.percentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_15);
            make.centerY.mas_equalTo(bottomView.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_62, YYSIZE_62));
        }];
    }
    return self;
}

- (void)setModel:(RunningRobotModel *)model {
    _model = model;
    self.titleView.text = model.Name;
    self.startView.text = [YYDateModel yy_getCustomTimeWithTimeStamp:model.StartTime];
    self.endView.text = [YYDateModel yy_getCustomTimeWithTimeStamp:model.ExpireTime];
    self.percentView.percent = model.RateOfProgress;
}

+ (NSString *)identifier {
    return @"RunningRobotCell";
}

@end
