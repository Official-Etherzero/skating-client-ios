//
//  YYTutorialController.m
//  ETZShard
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTutorialController.h"
#import "YYViewHeader.h"
#import "TutorialCell.h"
#import "TutorialModel.h"
#import "YYTutorialWebViewController.h"

@interface YYTutorialController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray<TutorialModel *> *models;

@end

@implementation YYTutorialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"新手教程");
    [self initSubViews];
}

- (void)initSubViews {
    self.listView = [[UITableView alloc] init];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.backgroundColor = COLOR_ffffff;
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_30);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_30);
        }
        make.left.right.mas_equalTo(self.view);
    }];
    self.listView.rowHeight = YYSIZE_110;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerClass:[TutorialCell class]
          forCellReuseIdentifier:TutorialCell.identifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark -UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TutorialCell *cell = [self.listView dequeueReusableCellWithIdentifier:TutorialCell.identifier
                                                                   forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TutorialModel *model = self.models[indexPath.row];
    YYTutorialWebViewController *webVC = [[YYTutorialWebViewController alloc] initWithLoadingUrlString:model.urlString];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy

- (NSMutableArray<TutorialModel *> *)models {
    if (!_models) {
        NSArray *arr = @[@"first_icon",@"second_icon",@"third_icon",@"four_icon",@"five_icon"];
        _models = @[].mutableCopy;
        for (id obj in arr) {
            TutorialModel *model = [[TutorialModel alloc] init];
            model.icon = obj;
            [_models addObject:model];
        }
    }
    return _models;
}


@end
