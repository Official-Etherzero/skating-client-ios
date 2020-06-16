//
//  CalculateStatisticalModel.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateStatisticalModel : NSObject

/**
 @parm
 "WHashrate": "integer,全网算力",
 "WNode": "integer,全网节点数",
 "MHashrate": "integer,我的算力",
 "THashrate": "integer,团队算力"
 */

@property (nonatomic,    copy) NSString  *MHashrate;
@property (nonatomic,    copy) NSString  *THashrate;
@property (nonatomic,    copy) NSString  *WHashrate;
@property (nonatomic,  assign) NSInteger WNode;


@end

NS_ASSUME_NONNULL_END
