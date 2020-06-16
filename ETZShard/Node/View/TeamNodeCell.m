//
//  TeamNodeCell.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "TeamNodeCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "NSString+Ext.h"

@interface TeamNodeCell ()

@property(nonatomic, strong) YYLabel     *userNameView;
@property(nonatomic, strong) YYLabel     *nodeView;
@property(nonatomic, strong) UIImageView *teamLevelView;

@end

@implementation TeamNodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = COLOR_198cff_A006;
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_90));
        }];
        
        UIImageView *leftView = [[UIImageView alloc] init];
        [bottomView addSubview:leftView];
        leftView.image = [UIImage imageNamed:@"icon"];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_20);
            make.centerY.mas_equalTo(bottomView.mas_centerY);
        }];
        
        self.userNameView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_1a1a1a text:@"********"];
        [bottomView addSubview:self.userNameView];
        [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftView.mas_right).offset(YYSIZE_20);
            make.top.mas_equalTo(leftView.mas_top).offset(YYSIZE_08);
        }];
        
        self.nodeView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_26 textColor:COLOR_1a1a1a_A06 text:@"******"];
        [bottomView addSubview:self.nodeView];
        [self.nodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userNameView.mas_left);
            make.bottom.mas_equalTo(leftView.mas_bottom);
        }];
        
        self.teamLevelView = [[UIImageView alloc] init];
        [bottomView addSubview:self.teamLevelView ];
        [self.teamLevelView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_10);
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_05);
        }];
    }
    return self;
}

- (void)setModel:(UserNodeModel *)model {
    NSString *numString = model.Email && model.Email.length > 0 ? model.Email : model.Phone;
    NSString *numberString = [numString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.userNameView.text = numberString;
    self.nodeView.text = [NSString stringWithFormat:@"节点数:%ld",(long)model.TeamNodeCount];
    if (model.TeamLevel > 0) {
        self.teamLevelView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_%ld",(long)model.TeamLevel]];
    }
}

+ (NSString *)identifier {
    return @"TeamNodeCell";
}


@end
