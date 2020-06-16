//
//  YYNodeViewController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/21.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeViewController.h"
#import "YYViewHeader.h"
#import "UIViewController+Ext.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYNodeViewModel.h"
#import "YYUserDefaluts.h"

#import "YYNodeHeaderView.h"
#import "YYMySelfNodeView.h"
#import "YYAddNodeView.h"
#import "YYTeamNodeView.h"
#import "YYInvitateView.h"
#import "YYChargeView.h"
#import "YYWithdrawalView.h"
#import "YYScrollView.h"

#import "YYInviteFriendsController.h"
#import "YYMySelfNodeController.h"
#import "YYAddNodeController.h"
#import "YYTeamNodeController.h"
#import "WDTransferController.h"
#import "WDCollectionController.h"
#import "YYTransferDetailController.h"
#import "YYTutorialController.h"

#import "MySelfNodeModel.h"
#import "TeamNodeModel.h"
#import "YYUserInfoViewModel.h"
#import "YYUserInfoModel.h"
#import "RequestModel.h"
#import "YYUserInfoModel.h"

@interface YYNodeViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) YYButton         *bannerView;
@property (nonatomic, strong) YYButton         *tutorialView;
@property (nonatomic, strong) YYNodeHeaderView *headerView;
@property (nonatomic, strong) YYMySelfNodeView *mySelfNodeView;
@property (nonatomic, strong) YYAddNodeView    *addNodeView;
@property (nonatomic, strong) YYInvitateView   *invitateView;
@property (nonatomic, strong) YYTeamNodeView   *teamNodeView;
@property (nonatomic, strong) YYScrollView     *mainSrollView;
@property (nonatomic, strong) YYNodeViewModel  *viewModel;
@property (nonatomic, strong) YYUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) NSMutableArray<YYNodeBaseView *>* nodeViews;
@property (nonatomic, strong) NSDictionary<NSIndexPath *, YYNodeBaseView *> *nodeViewDictionary;

@end

@implementation YYNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
    [self updateNodeData];
}

- (void)initSubViews {
    
    self.mainSrollView = [[YYScrollView alloc] initDefalutScrollView];
    [self.view addSubview:self.mainSrollView];
    self.mainSrollView.delegate = self;
    self.mainSrollView.frame = self.view.bounds;
    self.mainSrollView.contentSize = CGSizeMake(0, YYSIZE_750);
    
    self.headerView = [[YYNodeHeaderView alloc] init];
    [self.mainSrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainSrollView.mas_top).offset(YYSIZE_36);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_180));
    }];
    WDWeakify(self);
    self.headerView.chargeBlock = ^{
        // 充值
        WDStrongify(self);
        [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
                YYUserInfoModel *model = responseObject;
                WDCollectionController *vc = [[WDCollectionController alloc] initCollectionViewControllerWithAddress:model.RechargeAddr];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
               [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        } failure:^(NSError * _Nonnull error) {
            [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
        }];
    };
    
    self.headerView.withdrawalBlock = ^{
        // 提现
        [YYWithdrawalView showWithdrawalViewBlock:^(NSString * _Nonnull dataStr,NSString *address, NSString * _Nonnull psw) {
            WDStrongify(self);
            [self.userInfoViewModel yy_viewModelWithdrawWithToken:[YYUserDefaluts yy_getAccessTokeCache] address:address password:psw amount:dataStr success:^(id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[RequestModel class]]) {
                    RequestModel *model = responseObject;
                    [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
                    [self getUserInfo];
                }
            } failure:nil];
        } cancelBlock:nil];
    };
    
    self.headerView.detailBlock = ^{
        WDStrongify(self);
        YYTransferDetailController *vc = [YYTransferDetailController new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.bannerView = [[YYButton alloc] init];
    [self.bannerView setBackgroundImage:[UIImage imageNamed:@"banner"] forState:UIControlStateNormal];
    [self.mainSrollView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(YYSIZE_15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.bannerView bk_addEventHandler:^(id  _Nonnull sender) {
        // 签到
        WDStrongify(self);
        [self.userInfoViewModel yy_viewModelSignInWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[RequestModel class]]) {
                RequestModel *model = responseObject;
                if (model.code == 0) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"签到成功") attachedView:[UIApplication sharedApplication].keyWindow];
                    [self getUserInfo];
                } else {
                    [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
                }
            }
        } failure:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.tutorialView = [[YYButton alloc] init];
    [self.tutorialView setBackgroundImage:[UIImage imageNamed:@"tutorial_icon"] forState:UIControlStateNormal];
    [self.mainSrollView addSubview:self.tutorialView];
    [self.tutorialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(YYSIZE_15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.tutorialView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        YYTutorialController *vc = [[YYTutorialController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    NSArray<NSIndexPath *> *indexPathNSArray = [self.nodeViewDictionary allKeys];
    NSInteger numberOfRow = 0;
    for (int i = 0; i < self.nodeViews.count; i ++) {
        NSIndexPath *indexPath = indexPathNSArray[i];
        numberOfRow = indexPath.section + 1;
        YYNodeBaseView *view = self.nodeViewDictionary[indexPath];
        [self.mainSrollView addSubview:view];
        CGFloat cLeft = YYSIZE_08 + indexPath.row * (YYSIZE_178 + YYSIZE_05);
        CGFloat cHeght = YYSIZE_441 + indexPath.section * (YYSIZE_118 + YYSIZE_07);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).offset(cLeft);
            make.top.mas_equalTo(self.mainSrollView.mas_top).offset(cHeght);
            make.size.mas_offset(CGSizeMake(YYSIZE_178, YYSIZE_118));
        }];
        [view layoutIfNeeded];
        
        view.touchBlock = ^(YYNodeBaseView * _Nonnull view) {
            WDStrongify(self);
            if ([view isKindOfClass:[YYMySelfNodeView class]]) {
                NSLog(@"个人节点");
                [self.navigationController pushViewController:[YYMySelfNodeController new] animated:YES];
            } else if ([view isKindOfClass:[YYTeamNodeView class]]) {
                NSLog(@"团队节点");
                [self.navigationController pushViewController:[YYTeamNodeController new] animated:YES];
            } else if ([view isKindOfClass:[YYAddNodeView class]]) {
                NSLog(@"增加节点");
                [self.navigationController pushViewController:[YYAddNodeController new] animated:YES];
            } else if ([view isKindOfClass:[YYInvitateView class]]) {
                NSLog(@"邀请好友");
                [self.navigationController pushViewController:[YYInviteFriendsController new] animated:YES];
            }
        };
    }
}

- (void)initDatas {
    self.nodeViews = @[].mutableCopy;
    self.mySelfNodeView = [[YYMySelfNodeView alloc] init];
    self.teamNodeView = [[YYTeamNodeView alloc] init];
    self.addNodeView = [[YYAddNodeView alloc] init];
    self.invitateView = [[YYInvitateView alloc] init];
    [self.nodeViews addObject:self.mySelfNodeView];
    [self.nodeViews addObject:self.teamNodeView];
    [self.nodeViews addObject:self.addNodeView];
    [self.nodeViews addObject:self.invitateView];
    
    NSMutableDictionary<NSIndexPath *, UIView *> *dictionary = [[NSMutableDictionary alloc] initWithCapacity:[self.nodeViews count]];
    for (int i = 0; i < [self.nodeViews count]; i++) {
        NSInteger section = i / 2;
        NSInteger row = i % 2;
        dictionary[[NSIndexPath indexPathForRow:row inSection:section]] = self.nodeViews[i];
    }
    self.nodeViewDictionary = dictionary.copy;
    
    [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            YYUserInfoModel *model = responseObject;
            if (![YYUserDefaluts yy_getIsRealName] && model.IsTrueName == 1) {
                [YYUserDefaluts yy_setIsRealName:YES];
            }
            if (![YYUserDefaluts yy_getCurrentWalletAddress]) {
                [YYUserDefaluts yy_setCurrentWalletAddress:model.RechargeAddr];
            };
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:nil];
}

- (void)updateNodeData {
    WDWeakify(self);
    // 团队节点
    [self.viewModel yy_viewModelGetTeamNodeListWithPageSize:1 currentPage:10 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[TeamNodeModel class]]) {
            WDStrongify(self);
            self.teamNodeView.model = responseObject;
        }
    } failure:nil];
    
    [self.viewModel yy_viewModelMyNodeListWithPageSize:1 currentPage:10 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[MySelfNodeModel class]]) {
            WDStrongify(self);
            self.mySelfNodeView.model = responseObject;
        }
    } failure:nil];
    
    [self getUserInfo];
}

- (void)getUserInfo {
    WDWeakify(self);
    [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            WDStrongify(self);
            YYUserInfoModel *infoModel = responseObject;
            self.headerView.balnace = [NSString stringWithFormat:@"%@",infoModel.ETZ];
        }
    } failure:nil];
}

#pragma mark - lazy

- (YYNodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYNodeViewModel alloc] init];
    }
    return _viewModel;
}

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"dot"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"dot_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"节点");
}


@end
