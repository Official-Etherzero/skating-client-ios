//
//  YYMessageAuthenticateController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYMessageAuthenticateController.h"
#import "YYMessageView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "MessageViewModel.h"
#import "EmailViewModel.h"
#import "YYUserInfoModel.h"
#import "APIMacro.h"

@interface YYMessageAuthenticateController ()

@property (nonatomic, strong) YYMessageView     *messageView;
@property (nonatomic,   copy) NSArray           *types;
@property (nonatomic, strong) NSMutableArray    *modes;
@property (nonatomic, strong) MessageViewModel  *messageViewModel;
@property (nonatomic, strong) EmailViewModel    *emailViewModel;
@property (nonatomic, strong) UserInfoModel     *model;

@end

@implementation YYMessageAuthenticateController

- (instancetype)initWithCodeTypes:(NSArray *)codeTypes {
    if (self = [super init]) {
        self.types = codeTypes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewControllerDismiss)];
    [self.view addGestureRecognizer:tapGesture];
    [self initSubViews];
    [self initViewModel];
}

- (void)initSubViews {
   
    CGFloat viewHeight = YYSIZE_45 + YYSIZE_85 + self.types.count * YYSIZE_74;
    self.messageView = [[YYMessageView alloc] initMessageViewWithModelist:self.types];
    [self.view addSubview:self.messageView];
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, viewHeight));
    }];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10,10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.messageView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.messageView.layer.mask = maskLayer;
//    [self.messageView layoutIfNeeded];
    WDWeakify(self);
    self.messageView.hideBlock = ^{
        WDStrongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.messageView.messageBlock = ^(NSArray<CodeModel *> * _Nonnull models) {
        WDStrongify(self);
        if (self.handeCodeBlock) {
            self.handeCodeBlock(models);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.messageView.sendCodeBlock = ^(NSInteger code) {
      // 根据 code 去发消息 google 0 moblie 1 email 2
        if (code == 1) {
//            [YYVerificationView showVerificationViewWithBlock:^(NSString * _Nonnull verificate) {
//                [self.messageViewModel yy_viewModelMessageWithTokenMachine:verificate Type:kBindgoogle area:self.model.area mobile:self.model.mobile success:^(id responseObject) {
//                } failure:nil];
//            }];
        } else if (code == 2) {
//            [YYVerificationView showVerificationViewWithBlock:^(NSString * _Nonnull verificate) {
//                [self.emailViewModel yy_viewModelEmailWithTokenMachine:verificate Type:kBindgoogle email:self.model.email success:^(id responseObject) {
//
//                } failure:nil];
//            }];
        }
    };
}

- (void)initViewModel {
   
}

- (void)viewControllerDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy


- (NSArray *)types {
    if (!_types) {
        _types = [NSArray array];
    }
    return _types;
}

- (MessageViewModel *)messageViewModel {
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
    }
    return _messageViewModel;
}

- (EmailViewModel *)emailViewModel {
    if (!_emailViewModel) {
        _emailViewModel = [[EmailViewModel alloc] init];
    }
    return _emailViewModel;
}

@end
