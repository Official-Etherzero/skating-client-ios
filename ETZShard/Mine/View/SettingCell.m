//
//  SettingCell.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/22.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "SettingCell.h"
#import "YYViewHeader.h"
#import "YYUserDefaluts.h"

@interface SettingCell ()

@property(nonatomic, strong, readwrite) YYLabel      *titleView;
@property(nonatomic, strong, readwrite) YYLabel      *desView;

@end

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        separatorView.backgroundColor = COLOR_d4d4d4;
        [self addSubview:separatorView];
        [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_12);
            make.right.mas_equalTo(self).offset(-YYSIZE_12);
            make.bottom.mas_equalTo(self).offset(-1);
            make.height.mas_equalTo(0.5);
        }];
        
        self.titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_30 textColor:COLOR_090814 text:@""];
        [self addSubview:self.titleView];
        self.titleView.textAlignment = NSTextAlignmentLeft;
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(YYSIZE_12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_offset(YYSIZE_100);
        }];
        
        UIImageView *arrowView = [[UIImageView alloc] init];
        arrowView.image = [UIImage imageNamed:@"Arrow_btn"];
        [self addSubview:arrowView];
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.desView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_090814 text:@""];
        [self addSubview:self.desView];
        self.desView.textAlignment = NSTextAlignmentRight;
        [self.desView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowView.mas_left).offset(-YYSIZE_05);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_offset(YYSIZE_200);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleView.text = title;
    self.desView.text = [YYUserDefaluts yy_getValueForKey:title];
}

+ (NSString *)identifier {
    return @"SettingCell";
}

@end
