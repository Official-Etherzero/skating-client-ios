//
//  YYFunctionView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYFunctionView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "ImageCenterButton.h"

@implementation YYFunctionView

- (instancetype)initWithImages:(NSArray *)images titles:(NSArray *)titles; {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        self.layer.shadowColor = COLOR_d2d4d9_A02.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10.0f;
        self.layer.cornerRadius = 10.0f;
        UIButton *lastView = nil;
        CGFloat kleft = (YYSIZE_331 - titles.count * YYSIZE_60) / 4.0;
        for (int i = 0; i < titles.count; i++) {
            NSString *_t = titles[i];
            NSString *_img = images[i];
            WDWeakify(self);
            ImageCenterButton *btn = ({
                ImageCenterButton *v = [ImageCenterButton buttonWithType:UIButtonTypeCustom];
                v.tag = i;
                [v setImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
                [v bk_addEventHandler:^(id  _Nonnull sender) {
                    WDStrongify(self);
                    if ([self.delegate respondsToSelector:@selector(yy_functionClickWithCurrentIndex:)]) {
                        [self.delegate yy_functionClickWithCurrentIndex:v.tag];
                    }
                } forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:v];
                [v setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
                [v setTitleColor:COLOR_1a1a1a forState:UIControlStateNormal];
                [v.titleLabel setFont:FONT_DESIGN_24];
                [v setImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
                v.imageTextSpace = 10.0f;
                [v mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.left.mas_equalTo(lastView.mas_right).offset(kleft);
                    } else {
                        make.left.mas_equalTo(self.mas_left).offset(kleft);
                    }
                    make.width.mas_offset(YYSIZE_60);
                    make.centerY.mas_equalTo(self.mas_centerY);
                }];
                lastView = v;
                v;
            });
        }
    }
        return self;
}

@end
