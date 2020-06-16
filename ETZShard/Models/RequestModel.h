//
//  RequestModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic,   copy) NSString  *msg;
@property (nonatomic,   weak) id        data;

@end

NS_ASSUME_NONNULL_END
