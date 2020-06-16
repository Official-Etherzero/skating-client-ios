//
//  TutorialCell.m
//  ETZShard
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "TutorialCell.h"
#import "YYViewHeader.h"

@interface TutorialCell ()

@property (nonatomic, strong) UIImageView *tuView;

@end

@implementation TutorialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tuView = [[UIImageView alloc] init];
        [self addSubview:self.tuView];
        [self.tuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(TutorialModel *)model {
    _model = model;
    self.tuView.image = [UIImage imageNamed:model.icon];
}

+ (NSString *)identifier {
    return @"TutorialCell";
}

@end
