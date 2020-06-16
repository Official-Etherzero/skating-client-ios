//
//  YYUserListView.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYUserListView.h"
#import "YYViewHeader.h"
#import "PersonalCenterCell.h"
#import "YYInterfaceMacro.h"

#import "YYSecurityCenterController.h"
#import "YYSettingController.h"
#import "YYInviteFriendsController.h"
#import "YYAnnouncementCenterController.h"
#import "YYRealNameCertificationController.h"


#define REAL_NAME            [NSIndexPath indexPathForRow:0 inSection:0]
#define SECURITY_CENTER      [NSIndexPath indexPathForRow:1 inSection:0]
#define SETTING_PREFRENCE    [NSIndexPath indexPathForRow:2 inSection:0]
#define INVITE_FRIENDS       [NSIndexPath indexPathForRow:0 inSection:1]
#define ANNUNCE_MENT         [NSIndexPath indexPathForRow:1 inSection:1]


@interface YYUserListView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView  *listView;

@end

@implementation YYUserListView

- (void)setDataSource:(SettingDataSource *)dataSource {
    _dataSource = dataSource;
    [self.listView reloadData];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView {
    self.listView = [[UITableView alloc] init];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    [self addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.listView.rowHeight = YYSIZE_60;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerClass:[PersonalCenterCell class]
           forCellReuseIdentifier:PersonalCenterCell.identifier];
    if (@available(iOS 11.0, *)) {
        if ([self.listView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = COLOR_fafafa;
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell *cell = [self.listView dequeueReusableCellWithIdentifier:PersonalCenterCell.identifier
                                                                    forIndexPath:indexPath];
    cell.model = [self.dataSource rowWithIndexPath:indexPath];
    return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingRowModel *model = [self.dataSource rowWithIndexPath:indexPath];
    if (NSIndexPathEqual(indexPath,REAL_NAME)) {
        if ([self.delegate respondsToSelector:@selector(yy_clickViewController:)]) {
            [self.delegate yy_clickViewController:[[YYRealNameCertificationController alloc] initWithTitle:YYStringWithKey(model.title)]];
        }
    } else if (NSIndexPathEqual(indexPath, SECURITY_CENTER)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"敬请期待") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
        if ([self.delegate respondsToSelector:@selector(yy_clickViewController:)]) {
            [self.delegate yy_clickViewController:[[YYSecurityCenterController alloc] initWithTitle:YYStringWithKey(model.title)]];
        }
    } else if (NSIndexPathEqual(indexPath, SETTING_PREFRENCE)) {
        if ([self.delegate respondsToSelector:@selector(yy_clickViewController:)]) {
            [self.delegate yy_clickViewController:[[YYSettingController new] initWithTitle:YYStringWithKey(model.title)]];
        }
    } else if (NSIndexPathEqual(indexPath, INVITE_FRIENDS)) {
        if ([self.delegate respondsToSelector:@selector(yy_clickViewController:)]) {
            [self.delegate yy_clickViewController:[[YYInviteFriendsController alloc] initWithTitle: YYStringWithKey(model.title)]];
        }
    } else if (NSIndexPathEqual(indexPath, ANNUNCE_MENT)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"敬请期待") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
        return;
        if ([self.delegate respondsToSelector:@selector(yy_clickViewController:)]) {
            [self.delegate yy_clickViewController:[[YYAnnouncementCenterController alloc] initWithTitle :YYStringWithKey(model.title)]];
        }
    }
}

@end
