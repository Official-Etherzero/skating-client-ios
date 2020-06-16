//
//  YYTeamNodeView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNodeBaseView.h"
#import "TeamNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYTeamNodeView : YYNodeBaseView

@property (nonatomic, strong) TeamNodeModel *model;

@end

NS_ASSUME_NONNULL_END
