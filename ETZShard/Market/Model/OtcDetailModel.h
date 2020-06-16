//
//  OtcDetailModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/30.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtcDetailModel : NSObject

@property (nonatomic,   copy) NSString  *USDTReceAddr;
@property (nonatomic,   copy) NSString  *USDTSysAddr;
@property (nonatomic, assign) NSInteger IsActive;
@property (nonatomic, assign) float     Price;


@end

NS_ASSUME_NONNULL_END
