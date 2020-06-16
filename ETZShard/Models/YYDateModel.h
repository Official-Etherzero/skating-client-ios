//
//  YYDateModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYDateModel : NSObject

+ (NSString *)yy_getTimeFromTimeStamp:(double)stamp;

+ (NSString *)yy_getFullTimeWithTimeStamp:(double)stamp;

+ (NSString *)yy_getCustomTimeWithTimeStamp:(NSTimeInterval)stamp;

+ (NSDate *)yy_currentTime;

+ (NSDate *)yy_nextDayTime;

+ (NSDate *)yy_markTimeByCurrentTime:(NSDate *)date;

+ (NSString *)yy_currentDay;

+ (NSString *)yy_afterCurrentDays:(NSInteger)days;

+ (BOOL)yy_compareDate:(NSDate *)stary withDate:(NSDate *)end;

@end

NS_ASSUME_NONNULL_END
