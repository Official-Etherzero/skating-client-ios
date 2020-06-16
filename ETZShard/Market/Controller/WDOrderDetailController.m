//
//  WDOrderDetailController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDOrderDetailController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"
#import "NSString+Ext.h"
#import "StatusDetailView.h"

@interface WDOrderDetailController ()

@property (nonatomic, strong) OrderModel  *model;
@property (nonatomic, assign) OrderStatus status;

@end

@implementation WDOrderDetailController

- (instancetype)initViewControllerWithModel:(OrderModel *)model status:(OrderStatus)status {
    if (self = [super init]) {
        self.model = model;
        self.status = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = self.model.direction == 1 ? YYStringWithKey(@"Sell") : YYStringWithKey(@"Buy");
    [self initSubViews];
}

- (void)initSubViews {
    
    StatusDetailView *detailView = [[StatusDetailView alloc] initWithOrderModel:self.model status:self.status];
    [self.view addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_370));
    }];
    
    NSString *statusTitle = yyGetOrderStatusString(self.status);
    YYButton *statusTitleView = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.5 borderColoer:COLOR_1a1a1a_A03.CGColor masksToBounds:YES title:statusTitle titleColor:COLOR_1a1a1a_A05 backgroundColor:COLOR_ffffff cornerRadius:5.0f];
    statusTitleView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:statusTitleView];
    [statusTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(detailView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_45));
    }];
    statusTitleView.enabled = NO;
}


@end
