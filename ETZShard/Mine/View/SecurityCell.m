//
//  SecurityCell.m
//  ExchangeClientForIOS
//
//  Created by yang on 2020/1/14.
//  Copyright © 2020 alibaba. All rights reserved.
//

#import "SecurityCell.h"
#import "YYViewHeader.h"

@interface SecurityCell ()

@property(nonatomic, strong, readwrite) UIImageView  *arrowView;
@property(nonatomic, strong, readwrite) UILabel      *titleLabel;
@property(nonatomic, strong, readwrite) UILabel      *desLabel;
@property(nonatomic, strong, readwrite) UIView       *separatorView;

@end

@implementation SecurityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        self.separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        self.separatorView.backgroundColor = COLOR_edf0f5;
        [self addSubview:self.separatorView];
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_12);
            make.right.mas_equalTo(self).offset(-YYSIZE_12);
            make.bottom.mas_equalTo(self).offset(-0.5);
            make.height.mas_equalTo(0.5);
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_22);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_btn"]];
        [self addSubview:self.arrowView];
        [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_21);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowView.mas_left).offset(-YYSIZE_08);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(SecurityModel *)model {
    self.titleLabel.text = model.title;
    self.desLabel.text = model.statusString;
    self.desLabel.textColor = model.desColor;
}

+ (NSString *)identifier {
    return @"SecurityCell";
}

#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = COLOR_1a1a1a;
        _titleLabel.font = FONT_DESIGN_28;
    }
    return _titleLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.textAlignment = NSTextAlignmentRight;
        _desLabel.textColor = COLOR_5d4fe0;
        _desLabel.font = FONT_DESIGN_28;
    }
    return _desLabel;
}

@end
