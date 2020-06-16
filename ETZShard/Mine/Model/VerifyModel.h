//
//  VerifyModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyModel : NSObject

@property (nonatomic,   copy) NSString  *RequestId;
@property (nonatomic,   copy) NSString  *VerifyToken;
@property (nonatomic, assign) NSInteger VerifyStatus;

@end

NS_ASSUME_NONNULL_END
