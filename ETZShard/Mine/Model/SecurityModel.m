//
//  SecurityModel.m
//  ExchangeClientForIOS
//
//  Created by yang on 2020/1/14.
//  Copyright © 2020 alibaba. All rights reserved.
//

#import "SecurityModel.h"

@implementation SecurityModel

+ (instancetype)modelWithTitle:(NSString *)title des:(NSString *)des color:(nonnull UIColor *)color {
    SecurityModel *model = [[SecurityModel alloc] init];
    model.title = title;
    model.statusString = des;
    model.desColor = color;
    return model;
}

@end
