//
//  NodeRewardCell.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "NodeRewardCell.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"

@interface NodeRewardCell ()

@property (nonatomic, strong) YYLabel  *timeView;
@property (nonatomic, strong) YYLabel  *incomeView;

@end

@implementation NodeRewardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_335, 0.5));
        }];
        
        self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a text:@""];
        self.timeView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeView];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        }];
        
        self.incomeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a text:@""];
        self.incomeView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.incomeView];
        [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
        }];
    }
    return self;
}

- (void)setModel:(RewardModel *)model {
    _model = model;
    self.timeView.text = model.WriteTime;
    self.incomeView.text = [NSString stringWithFormat:@"+ %@ ETZ",[[NSString stringWithFormat:@"%ld",(long)model.Amount] yy_holdDecimalPlaceToIndex:4]];
}
+ (NSString *)identifier {
    return @"NodeRewardCell";
}


@end
