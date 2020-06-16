//
//  YYPercentView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/1/8.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYPercentView.h"
#import "YYViewHeader.h"

@interface YYPercentView ()

@property (nonatomic, strong) YYLabel *contentView;

@end

@implementation YYPercentView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.borderColor = COLOR_3d5afe.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = YYSIZE_31;
        self.clipsToBounds = YES;
        
        self.contentView = [[YYLabel alloc] initWithFont:FONT_BEBAS_36 textColor:COLOR_3d5afe text:@"0%"];
        self.contentView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setPercent:(NSString *)percent {
    _percent = percent;
    self.contentView.text = percent;
}


@end
