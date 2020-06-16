//
//  TransferView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlanceModel.h"
#import "YYEnum.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TransferBlock)(float ubi,TransferType type);

@interface TransferView : UIView

@property (nonatomic, strong) BlanceModel   *model;
@property (nonatomic,   copy) TransferBlock transferBlock;
@property (nonatomic,   copy) NSString      *blance;
@property (nonatomic, assign) TransferType  type;

@end

NS_ASSUME_NONNULL_END
