//
//  YYGCDTimer.h
//  PizzaRecipe
//
//  Created by yang on 2020/3/10.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYGCDTimer : NSObject

/*
  @param target
  @param selector
  @param start
  @param interval
  @param repeats
  @param async  child thread
  @return identifer
 */

+ (NSString *)timerTask:(id)target
               selector:(SEL)selector
                  start:(NSTimeInterval)start
               interval:(NSTimeInterval)interval
                repeats:(BOOL)repeats
                  async:(BOOL)async;

+ (void)suspendedTimer:(NSString *)identifer;

+ (void)resumeTimer:(NSString *)identifer;

+ (void)canelTimer:(NSString *)identifer;

@end

NS_ASSUME_NONNULL_END
