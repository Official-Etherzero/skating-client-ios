//
//  YYCodeInputView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/10.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYCodeInputView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"

@interface YYCodeInputView ()
<UITextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;

@end

/** 80 * 80*/
@implementation YYCodeInputView

- (instancetype)initCodeInputViewWithTitle:(NSString *)title
                                    plcStr:(NSString *)plcStr {
    if (self = [super init]) {
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_22 textColor:COLOR_090814 text:YYStringWithKey(title)];
        [titleView yy_setLineSpace:0];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_12);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_18);
            make.width.mas_offset(YYSIZE_120);
        }];
        
        self.textView = [YYTextView new];
        self.textView.backgroundColor = COLOR_ffffff;
        self.textView.textColor = COLOR_1a1a1a;
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.font = FONT_DESIGN_28;
        self.textView.placeholder = YYStringWithKey(plcStr);
        self.textView.placeholderColor = COLOR_1a1a1a_A025;
        self.textView.delegate = self;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_05);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_08);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_10);
            make.height.mas_offset(YYSIZE_30);
        }];
        
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = COLOR_090814_A008;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_05);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH - YYSIZE_20, 0.5));
        }];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.textView.text = content;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.content = textView.text;
}


@end
