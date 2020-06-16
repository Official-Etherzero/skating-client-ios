//
//  YYRealNameCertificationController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYRealNameCertificationController.h"
#import "YYViewHeader.h"
#import <RPSDK/RPSDK.h>
#import "YYUserInfoViewModel.h"
#import "YYUserDefaluts.h"
#import "YYInterfaceMacro.h"
#import "VerifyModel.h"

@interface YYRealNameCertificationController ()

@property (nonatomic, strong) YYUserInfoViewModel *infoViewModel;

@end

@implementation YYRealNameCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self getDatas];
}

- (void)getDatas {
    WDWeakify(self);
    [self.infoViewModel yy_viewModelGetVerifyTokenWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[VerifyModel class]]) {
            VerifyModel *model = responseObject;
            WDStrongify(self);
            [self verifyWithToken:model.VerifyToken];
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:nil];
}

- (void)verifyWithToken:(NSString *)token {
    WDWeakify(self);
    [RPSDK startWithVerifyToken:token
                 viewController:self
                     completion:^(RPResult * _Nonnull result) {
        WDStrongify(self);
        switch (result.state) {
            case RPStatePass: {
                // 认证通过。
                WDStrongify(self);
                [self.infoViewModel yy_viewModelGetVerifyResultWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
                    if ([responseObject isKindOfClass:[VerifyModel class]]) {
                        VerifyModel *model = responseObject;
                        if (model.VerifyStatus == 1) {
                            // 实名通过
                            // 换账号的时候需要清除缓存
                            [YYUserDefaluts yy_setIsRealName:YES];
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow show:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                } failure:nil];
            }
                break;
            case RPStateFail: {
                 // 认证不通过。
                [YYToastView showCenterWithTitle:YYStringWithKey(@"认证不通过") attachedView:[UIApplication sharedApplication].keyWindow];
            }
                break;
            case RPStateNotVerify:
                // 未认证。
                // 通常是用户主动退出或者姓名身份证号实名校验不匹配等原因导致。
                // 具体原因可通过 result.errorCode 和 result.message 来区分（详见错误码说明）。
                break;
        }
    }];
}


#pragma mark - lazy

- (YYUserInfoViewModel *)infoViewModel {
    if (!_infoViewModel) {
        _infoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _infoViewModel;
}


@end
