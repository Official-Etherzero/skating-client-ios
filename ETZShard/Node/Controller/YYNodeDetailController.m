//
//  YYNodeDetailController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeDetailController.h"
#import "YYViewHeader.h"
#import "NodeDetailHeaderView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "NodeOrderDetailView.h"
#import "YYNodeViewModel.h"
#import "YYUserDefaluts.h"
#import "RequestModel.h"

@interface YYNodeDetailController ()

@property (nonatomic, strong) NodeModel *model;
@property (nonatomic, strong) NodeDetailHeaderView *headerView;
@property (nonatomic, strong) YYButton  *addView;
@property (nonatomic, strong) YYNodeViewModel *viewModel;

@end

@implementation YYNodeDetailController

- (instancetype)initNodeModel:(NodeModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.Name;
    self.view.backgroundColor = COLOR_ffffff;
    
    self.headerView = [[NodeDetailHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_26);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_26);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_90));
    }];
    self.headerView.model = self.model;
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_1a1a1a text:YYStringWithKey(@"产品介绍")];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerView.mas_left);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_40);
    }];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"有的产品介绍的文章，很标准，很套路，非常像销售的话术。实际上，如果我们想要写别人能记住的文章，一定要足够的独特和有深度。千篇一律不过是对已有内容的重复和搬运，毫无疑问是劳动力的浪费。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0]}];
//
//    label.attributedText = string;
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(titleView.mas_left);
//        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_15);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//    }];
    
    
    YYLabel *attentionView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_36 textColor:COLOR_1a1a1a text:YYStringWithKey(@"注意事项")];
    [self.view addSubview:attentionView];
    [attentionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerView.mas_left);
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_20);
    }];
    
//    UILabel *content = [[UILabel alloc] init];
//    content.numberOfLines = 0;
//    [self.view addSubview:content];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"有的产品介绍的文章，很标准，很套路，非常像销售的话术。实际上，如果我们想要写别人能记住的文章，一定要足够的独特和有深度。千篇一律不过是对已有内容的重复和搬运，毫无疑问是劳动力的浪费。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0]}];
//
//    content.attributedText = str;
//    [content mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(attentionView.mas_left);
//        make.top.mas_equalTo(attentionView.mas_bottom).offset(YYSIZE_15);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//    }];
    
    self.addView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 borderWidth:0 borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认增加") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:5.0f];
       [self.view addSubview:self.addView];
       [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
           if (iOS11) {
               make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_15);
           } else {
               make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(YYSIZE_15);
           }
           make.centerX.mas_equalTo(self.view.mas_centerX);
           make.size.mas_offset(CGSizeMake(331, 47));
       }];
       WDWeakify(self);
       [self.addView bk_addEventHandler:^(id  _Nonnull sender) {
           WDStrongify(self);
           [self showNodeOrderDetailView];
       } forControlEvents:UIControlEventTouchUpInside];
}

- (void)showNodeOrderDetailView {
    WDWeakify(self);
    [NodeOrderDetailView showOrderDetailViewWithModel:self.model confirmBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.viewModel yy_viewModelBuyNodeWithToken:[YYUserDefaluts yy_getAccessTokeCache] nodeId:self.model.MiniID password:psd success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[RequestModel class]]) {
                RequestModel *model = responseObject;
                if (model.code == 0) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"购买成功") attachedView:[UIApplication sharedApplication].keyWindow];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
                }
            }
        } failure:nil];
    } cancelBlock:nil];
}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

@end
