//
//  YYNodeBaseView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYNodeBaseView.h"

@implementation YYNodeBaseView

- (instancetype)init {
    if (self = [super init]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(tapAction)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)tapAction {
    if (self.touchBlock) {
        self.touchBlock(self);
    }
}

@end
