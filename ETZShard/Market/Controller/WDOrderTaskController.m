//
//  WDOrderTaskController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDOrderTaskController.h"
#import "YYPageView.h"
#import "OrderDetailCell.h"
#import "YYViewHeader.h"
#import "YYUserInfoViewModel.h"
#import "WalletDataManager.h"
#import "OrderListView.h"
#import "YYInterfaceMacro.h"
#import "WDOrderStatusController.h"
#import "WDOrderDetailController.h"

@interface WDOrderTaskController ()
<YYPageViewDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) YYPageView  *pageView;
@property (nonatomic, strong) YYUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,   copy) NSArray *models;
@property (nonatomic,   copy) NSArray *titles;

@property (nonatomic, strong) OrderListView *taskView;
@property (nonatomic, strong) OrderListView *completeView;
@property (nonatomic, strong) OrderListView *cancelView;

@end

@implementation WDOrderTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initViewModel];
}

- (void)initSubViews {
    
    self.titles = @[@"进行中",@"已完成",@"已取消"];
    CGFloat viewHeight = IS_IPHONE_X_orMore ? YYSIZE_88 : YYSIZE_64;
    self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, viewHeight, YYSCREEN_WIDTH, YYSIZE_50) titles:self.titles];
    [self.view addSubview:self.pageView];
    self.pageView.delegate = self;
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_edf0f5;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 0.5));
    }];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = CGSizeMake(YYSCREEN_WIDTH *self.models.count,0);
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.delaysContentTouches = NO;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(line.mas_bottom);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    if (@available(iOS 11.0, *)) {
        if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    self.taskView = [[OrderListView alloc] init];
    [self.scrollView addSubview:self.taskView];
    self.taskView.frame = CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_553);
    WDWeakify(self);
    self.taskView.selectedBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        WDOrderStatusController *statusVC = [[WDOrderStatusController alloc] initViewControllerWithModel:model];
        [self.navigationController pushViewController:statusVC animated:YES];
    };
    
    self.completeView = [[OrderListView alloc] init];
    [self.scrollView addSubview:self.completeView];
    self.completeView.frame = CGRectMake(YYSCREEN_WIDTH, 0, YYSCREEN_WIDTH, YYSIZE_553);
    self.completeView.selectedBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        WDOrderDetailController *statusVC = [[WDOrderDetailController alloc] initViewControllerWithModel:model status:ORDER_COMPLETE];
        [self.navigationController pushViewController:statusVC animated:YES];
    };
    
    self.cancelView = [[OrderListView alloc] init];
    self.cancelView.frame = CGRectMake(YYSCREEN_WIDTH * 2, 0, YYSCREEN_WIDTH, YYSIZE_553);
    [self.scrollView addSubview:self.cancelView];
    self.cancelView.selectedBlock = ^(OrderModel * _Nonnull model) {
        WDStrongify(self);
        WDOrderDetailController *statusVC = [[WDOrderDetailController alloc] initViewControllerWithModel:model status:ORDER_CANCEL];
        [self.navigationController pushViewController:statusVC animated:YES];
    };

    self.scrollView.contentSize = CGSizeMake(YYSCREEN_WIDTH *3, 0);
}

- (void)initViewModel {
    NSString *address = [WalletDataManager accountModel].address;
    // 1 进行中， 2， 已完成 3，已取消
    WDWeakify(self);
    [self.userInfoViewModel yy_viewModelGetListOrdersWithPage:0 pageSize:100 address:address type:1 success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.taskView.models = responseObject;
        }
    } failure:nil];
    
    [self.userInfoViewModel yy_viewModelGetListOrdersWithPage:0 pageSize:100 address:address type:2 success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.completeView.models = responseObject;
        }
    } failure:nil];
    
    [self.userInfoViewModel yy_viewModelGetListOrdersWithPage:0 pageSize:100 address:address type:3 success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.cancelView.models = responseObject;
        }
    } failure:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"Decelerating : %f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"Dragging : %f",scrollView.contentOffset.x);
    if ((int)scrollView.contentOffset.x > (YYSCREEN_WIDTH *self.pageView.index)
        && self.pageView.index < self.titles.count -1) {
        self.pageView.index ++;
        NSLog(@"........%ld",(long)self.pageView.index);
        [self selectImportViewIndex:self.pageView.index animate:YES];
        [scrollView scrollsToTop];
    } else if ((int)scrollView.contentOffset.x < (YYSCREEN_WIDTH *self.pageView.index)
               && self.pageView.index > 0) {
        self.pageView.index --;
        NSLog(@"kkkkkkk%ld",(long)self.pageView.index);
        [self selectImportViewIndex:self.pageView.index animate:YES];
    }
}

- (void)selectImportViewIndex:(NSUInteger)index animate:(BOOL)isAnimate {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *index, 0) animated:YES];
}

#pragma mark - YYPageViewDelegate

- (void)pageViewDidChangeIndex:(YYPageView *)pageView {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *pageView.index, 0) animated:YES];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

@end
