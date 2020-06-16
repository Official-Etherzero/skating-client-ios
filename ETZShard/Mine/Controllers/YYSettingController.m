//
//  YYSettingController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYSettingController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "SettingCell.h"
#import "UsersDefalutMacro.h"
#import "YYAlertView+Ext.h"
#import "YYUserDefaluts.h"

#import "YYLanguageSettingController.h"

static NSString *kSettingIdentifier = @"kSettingIdentifier";

@interface YYSettingController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSArray         *titles;

@end

@implementation YYSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    self.titles = @[SettingLanguage,DenominatedUnit,AppVersion];
    [YYUserDefaluts yy_setValue:@"中文(简体)" forkey:SettingLanguage];
    [YYUserDefaluts yy_setValue:@"人民币(CNY)" forkey:DenominatedUnit];
    [YYUserDefaluts yy_setValue:@"1.0" forkey:AppVersion];
}

- (void)initSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_ffffff;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:kSettingIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kSettingIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *title = self.titles[indexPath.row];
    cell.title = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 设置语言
        YYLanguageSettingController *vc = [[YYLanguageSettingController alloc] init];
        self.definesPresentationContext = YES;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc.modalPresentationCapturesStatusBarAppearance = YES;
        vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        // 计价单位
    } else if (indexPath.row == 2) {
        // 当前版本
        [YYAlertView showAlertViewWithAttachView:[UIApplication sharedApplication].keyWindow describe:YYStringWithKey(@"目前已是最新版本") comfirmTitle:YYStringWithKey(@"确定") confirm:nil];
    }
}

@end
