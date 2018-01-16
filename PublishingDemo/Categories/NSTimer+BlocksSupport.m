//
//  NSTimer+BlocksSupport.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2018/1/16.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "NSTimer+BlocksSupport.h"

@implementation NSTimer (BlocksSupport)

+ (NSTimer*)dxd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(dxd_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)dxd_blockInvoke:(NSTimer*)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
