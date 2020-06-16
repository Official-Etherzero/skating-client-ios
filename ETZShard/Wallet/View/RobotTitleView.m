//
//  RobotTitleView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotTitleView.h"
#import "YYViewHeader.h"

@interface RobotTitleView ()

@property (nonatomic, strong) YYLabel *contentView;

@end

@implementation RobotTitleView

- (instancetype)initWithLeftView:(NSString *)icon title:(NSString *)title {
    if (self = [super init]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:icon];
        [self addSubview:imageView];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A05 text:title];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_32 textColor:COLOR_1a1a1a text:@""];
        contentView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:contentView];
        self.contentView = contentView;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(self);
            make.size.mas_offset(CGSizeMake(YYSIZE_35, YYSIZE_35));
        }];
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(imageView.mas_right).offset(YYSIZE_10);
            make.height.mas_offset(YYSIZE_11);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleView.mas_left);
            make.height.mas_offset(YYSIZE_13);
            make.bottom.mas_equalTo(imageView.mas_bottom);
        }];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    self.contentView.text = content;
}

@end
