//
//  TransferView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "AccountsView.h"

@interface TransferView ()

@property (nonatomic, strong) YYLabel    *leftTitleView;
@property (nonatomic, strong) YYLabel    *rightTitleView;
@property (nonatomic, strong) YYButton   *leftConfirmView;
@property (nonatomic, strong) YYButton   *rightConfirmView;
@property (nonatomic, strong) YYLabel    *availableView;
@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) YYButton   *allSelectedView;
@property (nonatomic, strong) YYButton   *transferBtn;
@property (nonatomic, strong) AccountsView *leftView;
@property (nonatomic, strong) AccountsView *rightView;

@end

// 默认转账的机器人账户
// 0x69948e7dC1536Fc083DA5D85eedaE6bCE930b19a
@implementation TransferView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    WDWeakify(self);
    self.leftTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_1a1a1a text:[NSString stringWithFormat:@"%@ %@",YYStringWithKey(@"从"),YYStringWithKey(@"钱包账户")]];
    self.leftTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.leftTitleView];
    [self.leftTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_48);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_40);
    }];
    
    self.leftConfirmView = [YYButton buttonWithType:UIButtonTypeCustom];
    self.leftConfirmView.stretchLength = 10.0f;
    [self.leftConfirmView setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [self addSubview:self.leftConfirmView];
    [self.leftConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftTitleView.mas_centerY);
        make.left.mas_equalTo(self.leftTitleView.mas_right).offset(YYSIZE_03);
    }];
    [self.leftConfirmView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        self.leftView.hidden = NO;
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *centerView = [[UIImageView alloc] init];
    centerView.image = [UIImage imageNamed:@"change"];
    [self addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftTitleView.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    self.rightTitleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Medium_30 textColor:COLOR_1a1a1a text:[NSString stringWithFormat:@"%@ %@",YYStringWithKey(@"到"),YYStringWithKey(@"机器人账户")]];
    self.rightTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.rightTitleView];
    [self.rightTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerView.mas_right).offset(YYSIZE_28);
        make.top.mas_equalTo(self.leftTitleView.mas_top);
    }];
    
    self.rightConfirmView = [YYButton buttonWithType:UIButtonTypeCustom];
    self.rightConfirmView.stretchLength = 10.0f;
    [self.rightConfirmView setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [self addSubview:self.rightConfirmView];
    [self.rightConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightTitleView.mas_right).offset(YYSIZE_03);
        make.centerY.mas_equalTo(self.rightTitleView.mas_centerY);
    }];
    [self.rightConfirmView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        self.rightView.hidden = NO;
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIView *intervalView = [[UIView alloc] init];
    intervalView.backgroundColor = COLOR_f5f7fb;
    [self addSubview:intervalView];
    [intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_98);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_10));
    }];
    
    YYLabel *trasferTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a_A05 text:YYStringWithKey(@"划转数量")];
    trasferTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:trasferTitleView];
    [trasferTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.top.mas_equalTo(intervalView.mas_bottom).offset(YYSIZE_40);
    }];
    
    self.availableView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_1a1a1a text:[NSString stringWithFormat:@"%@ 888888 UBI",YYStringWithKey(@"可用:")]];
    self.availableView.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.availableView];
    [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(trasferTitleView.mas_centerY);
    }];
    
    YYTextView *addressView = [YYTextView new];
    addressView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
    addressView.placeholder = YYStringWithKey(@"请输入划转的数量");
    addressView.placeholderColor= COLOR_1a1a1a_A03;
    [self addSubview:addressView];
    addressView.layer.borderWidth = 0.5;
    addressView.layer.cornerRadius = 2.0;
    addressView.textAlignment = NSTextAlignmentLeft;
    [addressView setFont:FONT_DESIGN_26];
    addressView.textContainerInset = UIEdgeInsetsMake(YYSIZE_10, 3, YYSIZE_10,3);
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(trasferTitleView.mas_bottom).offset(YYSIZE_36);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_332,YYSIZE_36));
    }];
    self.textView = addressView;
    
    YYLabel *ubiView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_1a1a1a text:@"UBI"];
    ubiView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ubiView];
    [ubiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textView.mas_right).offset(-YYSIZE_58);
        make.centerY.mas_equalTo(self.textView.mas_centerY);
    }];
    
    self.allSelectedView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_26 title:YYStringWithKey(@"全部") titleColor:COLOR_3d5afe];
    self.allSelectedView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.allSelectedView];
    [self.allSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textView.mas_centerY);
        make.right.mas_equalTo(self.textView.mas_right).offset(-YYSIZE_10);
    }];
    [self.allSelectedView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        switch (self.leftView.currentIndex) {
            case 0:
                self.textView.text = self.model.UBIOUT;
                break;
            case 1:
                self.textView.text = self.model.UBIIN;
                break;
            case 2:
                self.textView.text = self.blance;
                break;
            default:
                break;
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.transferBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"划转") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
    self.transferBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.transferBtn];
    [self.transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_275);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    [self.transferBtn bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if ([self.textView.text floatValue] == 0) {
            return ;
        }
        switch (self.leftView.currentIndex) {
            case 0:
                if ([self.model.UBIOUT floatValue] == 0) {
                    return;
                }
                break;
            case 1:
                if ([self.model.UBIIN floatValue] == 0) {
                    return;
                }
                break;
            case 2:
                if ([self.blance floatValue] == 0) {
                    return;
                }
                break;
            default:
                break;
        }
        if (self.transferBlock) {
            self.transferBlock([self.textView.text floatValue],self.type);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *firstView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0] text:YYStringWithKey(@"*  机器人账户与交易账户间划转不需要手续费")];
    firstView.textAlignment = NSTextAlignmentLeft;
    firstView.numberOfLines = 0;
    firstView.alpha = 0.8;
    [self addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.top.mas_equalTo(self.transferBtn.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYLabel *secondView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0] text:YYStringWithKey(@"*  交易账户划转至钱包账户需要30%手续费")];
    secondView.textAlignment = NSTextAlignmentLeft;
    secondView.numberOfLines = 0;
    secondView.alpha = 0.8;
    [self addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.top.mas_equalTo(firstView.mas_bottom).offset(YYSIZE_03);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    // 默认钱包到机器人
    self.type = TRANSFER_WAL_ROBOT;
    [self initAccountsView];
}

- (void)initAccountsView {
    WDWeakify(self);
    self.leftView = [[AccountsView alloc] initViewTapsBlock:^(NSInteger index) {
        WDStrongify(self); // 交易账户 -> 钱包账户 、机器人账户; 机器人账户 -> 交易账户; 钱包账户 -> 机器人账户;
        self.leftTitleView.text = [NSString stringWithFormat:@"%@ %@",YYStringWithKey(@"从"),yyGetAccountTypeString(index)];
        self.leftView.hidden = YES;
        if (index == 0) {
            if (self.rightView.currentIndex == 0) {
                self.rightView.currentIndex = 1;
                // 交易账户到机器人
                self.type = TRANSFER_TRA_ROBOT;
            } else if (self.rightView.currentIndex == 1) {
                // 交易账户到机器人
                self.type = TRANSFER_TRA_ROBOT;
            } else {
                // 交易账户到钱包账户
                self.type = TRANSFER_TRA_WALLET;
            }
            self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.model.UBIOUT];
        } else if (index == 1) {
            if (self.rightView.currentIndex != 0) {
                self.rightView.currentIndex = 0;
                // 机器人到交易账户
            }
            self.type = TRANSFER_ROB_TRANSFER;
            self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.model.UBIIN];
        } else if (index == 2) {
            if (self.rightView.currentIndex != 1) {
                self.rightView.currentIndex = 1;
                // 钱包到机器人
            }
            self.type = TRANSFER_WAL_ROBOT;
            self.availableView.text =  [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.blance];
        }
    } selectedIndex:ACCOUNT_WALLET];
    self.leftView.layer.borderColor = COLOR_dcdcdc.CGColor;
    self.leftView.layer.borderWidth = 0.5;
    [self addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.leftConfirmView.mas_left);
        make.top.mas_equalTo(self.leftConfirmView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_95));
    }];
    self.leftView.hidden = YES;
    
    self.rightView = [[AccountsView alloc] initViewTapsBlock:^(NSInteger index) {
        WDStrongify(self);
        self.rightTitleView.text = [NSString stringWithFormat:@"%@ %@",YYStringWithKey(@"到"),yyGetAccountTypeString(index)];
        self.rightView.hidden = YES;
        // 交易账户 -> 钱包账户 、机器人账户; 机器人账户 -> 交易账户; 钱包账户 -> 机器人账户;
        if (index == 0) {
            if (self.leftView.currentIndex != 1) {
                self.leftView.currentIndex = 1;
                // 机器人 - 交易账户
            }
            self.type = TRANSFER_ROB_TRANSFER;
            self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.model.UBIIN];
        } else if (index == 1) {
            if (self.leftView.currentIndex == 1) {
                self.leftView.currentIndex = 0;
                // 交易账户到机器人
            }
            self.type = TRANSFER_TRA_ROBOT;
            self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.model.UBIOUT];
        } else if (index == 2) {
            if (self.leftView.currentIndex != 0) {
                self.leftView.currentIndex = 0;
                // 交易账户到钱包
            }
            self.type = TRANSFER_TRA_WALLET;
            self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.model.UBIOUT];
        }
    } selectedIndex:ACCOUNT_ROBOT];
    self.rightView.layer.borderColor = COLOR_dcdcdc.CGColor;
    self.rightView.layer.borderWidth = 0.5;
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightConfirmView.mas_left);
        make.top.mas_equalTo(self.rightConfirmView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_95));
    }];
    self.rightView.hidden = YES;
}

- (void)setModel:(BlanceModel *)model {
    _model = model;
    if (self.leftView.currentIndex == 0) {
        self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),model.UBIOUT];
    } else if (self.leftView.currentIndex == 1) {
        self.availableView.text = [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),model.UBIIN];
    }
}

- (void)setBlance:(NSString *)blance {
    _blance = blance;
    if (self.leftView.currentIndex == 2) {
        self.availableView.text =  [NSString stringWithFormat:@"%@ %@ UBI",YYStringWithKey(@"可用:"),self.blance];
    }
}

@end
