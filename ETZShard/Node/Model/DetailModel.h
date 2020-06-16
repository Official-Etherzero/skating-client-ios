//
//  DetailModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

@property (nonatomic, assign) NSInteger  Amount;
@property (nonatomic, assign) NSInteger  inout;
@property (nonatomic,   copy) NSString   *WriteTime;
@property (nonatomic,   copy) NSString   *Remark;

@end

NS_ASSUME_NONNULL_END
