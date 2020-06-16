//
//  TeamNodeModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserNodeModel : NSObject

@property (nonatomic,   copy) NSString  *Phone;
@property (nonatomic,   copy) NSString  *Email;
@property (nonatomic,   copy) NSString  *UserID;
@property (nonatomic, assign) NSInteger TeamLevel;
@property (nonatomic, assign) NSInteger TeamNodeCount;
@property (nonatomic, assign) NSInteger subCount;

@end

@class UserNodeModel;
@interface TeamNodeModel : NSObject

@property (nonatomic,   copy) NSString  *RewardYesterday;
@property (nonatomic,   copy) NSString  *TeamReward;
@property (nonatomic, assign) NSInteger PeopleCount;    // 有效直推
@property (nonatomic, assign) NSInteger PeopleCount2;   // 直推
@property (nonatomic, assign) NSInteger TeamLevel;
@property (nonatomic, assign) NSInteger TeamNodeAmount;
@property (nonatomic, assign) NSInteger TeamNodeCount;
@property (nonatomic,   copy) NSArray<UserNodeModel *> *UserNodeList;

@end

NS_ASSUME_NONNULL_END
