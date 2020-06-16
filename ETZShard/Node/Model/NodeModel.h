//
//  NodeModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NodeModel : NSObject

@property (nonatomic,   copy) NSString  *Period;
@property (nonatomic,   copy) NSString  *Remark;
@property (nonatomic,   copy) NSString  *Input;
@property (nonatomic,   copy) NSString  *Name;
@property (nonatomic, assign) NSInteger MaxNode;
@property (nonatomic, assign) NSInteger MType;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) NSInteger Earnings;
@property (nonatomic, assign) NSInteger flag;

@end

NS_ASSUME_NONNULL_END
