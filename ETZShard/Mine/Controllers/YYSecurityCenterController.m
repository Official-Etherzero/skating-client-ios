//
//  YYSecurityCenterController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/21.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYSecurityCenterController.h"
#import "YYViewHeader.h"
#import "PersonalCenterCell.h"
#import "SettingDataSource.h"

#import "YYInterfaceMacro.h"

#import "YYGoogleValidatorController.h"
#import "YYBindEmailController.h"
#import "YYBindPhoneController.h"
#import "YYChangePasswordController.h"
#import "YYUserInfoModel.h"
#import "UserInfoModel.h"
#import "SecurityModel.h"
#import "SecurityCell.h"

#import "YYPhoneVerificationController.h"

static NSString *kSecurityCenterIdentifier = @"kSecurityCenterIdentifier";

#define BIND_GOOGLE          [NSIndexPath indexPathForRow:0 inSection:0]
#define BIND_EMAIL           [NSIndexPath indexPathForRow:1 inSection:0]
#define BIND_PHONE           [NSIndexPath indexPathForRow:2 inSection:0]
#define CHANGE_PASSWORD      [NSIndexPath indexPathForRow:3 inSection:0]

@interface YYSecurityCenterController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) SettingDataSource  *listSource;
@property (nonatomic, strong) UserInfoModel      *userInfoModel;
@property (nonatomic, strong) NSMutableArray     *models;
@property (nonatomic,   copy) NSArray *titles;

@end

@implementation YYSecurityCenterController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initViewModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initDatas];
    [self initSubViews];
}

- (void)initDatas {
    
    NSArray *models = @[[SecurityModel modelWithTitle:YYStringWithKey(@"谷歌二次验证") des:YYStringWithKey(@"未绑定") color:COLOR_090814],
                       [SecurityModel modelWithTitle:YYStringWithKey(@"绑定邮箱") des:YYStringWithKey(@"点击绑定") color:COLOR_5d4fe0],
                       [SecurityModel modelWithTitle:YYStringWithKey(@"绑定手机") des:YYStringWithKey(@"点击绑定") color:COLOR_5d4fe0],
                       [SecurityModel modelWithTitle:YYStringWithKey(@"登录密码") des:YYStringWithKey(@"点击修改") color:COLOR_5d4fe0]
                       ];
    self.models = models.mutableCopy;
}

- (void)initSubViews {
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    self.tableView.rowHeight = YYSIZE_58;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SecurityCell class]
           forCellReuseIdentifier:[SecurityCell identifier]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

- (void)initViewModel {
//    WDWeakify(self);
//    [self.viewModel yy_viewModelWithSuccess:^(id responseObject) {
//        WDStrongify(self);
//        if ([responseObject isKindOfClass:[UserInfoModel class]]) {
//            self.userInfoModel = responseObject;
//            // 手机和邮箱判断 1、4 谷歌验证判断 1、3、4
//            [self.models removeAllObjects];
//            NSString *googleStr = @"";
//            UIColor *googleColor;;
//            if ([self.userInfoModel.google_status isEqualToString:@"1"]) {
//                googleStr = YYStringWithKey(@"已开启");
//                googleColor = COLOR_2ad194;
//            } else if ([self.userInfoModel.google_status isEqualToString:@"2"]) {
//                googleStr = YYStringWithKey(@"未开启");
//                googleColor = COLOR_ff4e5b;
//            } else {
//                googleStr = YYStringWithKey(@"点击绑定");
//                googleColor = COLOR_5d4fe0;
//            }
//            NSString *phoneStr = [self.userInfoModel.mobile_status isEqualToString:@"1"] ? self.userInfoModel.mobile : YYStringWithKey(@"点击绑定");
//            UIColor *phoneColor = [self.userInfoModel.mobile_status isEqualToString:@"1"] ? COLOR_090814 : COLOR_5d4fe0;
//            NSString *emailStr = [self.userInfoModel.email_status isEqualToString:@"1"] ? self.userInfoModel.email : YYStringWithKey(@"点击绑定");
//            UIColor *emailColor = [self.userInfoModel.mobile_status isEqualToString:@"1"] ? COLOR_090814 : COLOR_5d4fe0;
//            NSArray *models = @[[SecurityModel modelWithTitle:YYStringWithKey(@"谷歌二次验证") des:googleStr color:googleColor],
//                                [SecurityModel modelWithTitle:YYStringWithKey(@"绑定邮箱") des:emailStr color:emailColor],
//                                [SecurityModel modelWithTitle:YYStringWithKey(@"绑定手机") des:phoneStr color:phoneColor],
//                                [SecurityModel modelWithTitle:YYStringWithKey(@"登录密码") des:YYStringWithKey(@"点击修改") color:COLOR_5d4fe0]
//                                ];
//            self.models = models.mutableCopy;
//            [self.tableView reloadData];
//        }
//    } failure:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecurityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[SecurityCell identifier] forIndexPath:indexPath];    
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecurityModel *model = self.models[indexPath.row];
    if (NSIndexPathEqual(indexPath,BIND_GOOGLE)) {
        // 根据状态来选择
        [self.navigationController pushViewController:[[YYGoogleValidatorController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, BIND_EMAIL)) {
//        if (![self.userInfoModel.email_status isEqualToString:@"1"]) {
//            [self.navigationController pushViewController:[[YYBindEmailController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
//        }
    } else if (NSIndexPathEqual(indexPath, BIND_PHONE)) {
//        if ([self.userInfoModel.mobile_status isEqualToString:@"4"]) {
//            [self.navigationController pushViewController:[[YYBindPhoneController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
//        } else {
//            YYPhoneVerificationController *phoneVerificationVC = [YYPhoneVerificationController new];
//            phoneVerificationVC.model = self.userInfoModel;
//            [self.navigationController pushViewController:phoneVerificationVC animated:YES];
//        }
    } else if (NSIndexPathEqual(indexPath, CHANGE_PASSWORD)) {
        [self.navigationController pushViewController:[[YYChangePasswordController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    }
}

#pragma mark - lazy

- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}


@end
