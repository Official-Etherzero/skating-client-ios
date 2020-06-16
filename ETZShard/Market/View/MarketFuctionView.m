//
//  MarketFuctionView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "MarketFuctionView.h"
#import "YYViewHeader.h"

@interface MarketFuctionView ()

@property (nonatomic, strong) NSMutableArray<UIButton *>* taps;

@end

@implementation MarketFuctionView

- (instancetype)init {
    if (self = [super init]) {
        NSArray *titles = @[@"买入",@"卖出",@"划转"];
        self.taps = @[].mutableCopy;
        YYButton *lastView = nil;
        for (int i = 0; i < titles.count; i ++) {
            NSString *_t = titles[i];
            YYButton *view = [YYButton buttonWithType:UIButtonTypeCustom];
            view.tag = i;
            [view setTitleColor:COLOR_3d5afe forState:UIControlStateNormal];
            [view setTitleColor:COLOR_ffffff forState:UIControlStateSelected];
            [view setBackgroundImage:[UIImage yy_imageWithColor:COLOR_ffffff] forState:UIControlStateNormal];
            [view setBackgroundImage:[UIImage yy_imageWithColor:COLOR_3d5afe] forState:UIControlStateSelected];
            [view setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
            view.layer.cornerRadius = 3.0f;
            view.clipsToBounds = YES;
            view.layer.borderColor = COLOR_3d5afe.CGColor;
            view.layer.borderWidth = 0.5f;
            [self addSubview:view];
            [view addTarget:self action:@selector(chainClick:) forControlEvents:UIControlEventTouchUpInside];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(YYSIZE_15_5);
                    make.centerY.mas_equalTo(self.mas_centerY);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
                    make.centerY.mas_equalTo(self.mas_centerY);
                }
                make.size.mas_offset(CGSizeMake(YYSIZE_100, YYSIZE_32));
            }];
            lastView = view;
            [self.taps addObject:view];
            if (i == 0) {
                view.selected = YES;
            }
        }
    }
    return self;
}

- (void)chainClick:(UIButton *)sender {
    [self.taps enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = sender == button;
    }];
    if ([self.delegate respondsToSelector:@selector(yy_showPageViewIndex:)]) {
        [self.delegate yy_showPageViewIndex:sender.tag];
    }
}



@end
