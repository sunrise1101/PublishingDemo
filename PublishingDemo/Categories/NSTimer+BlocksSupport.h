//
//  NSTimer+BlocksSupport.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2018/1/16.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlocksSupport)

+ (NSTimer*)dxd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats;

@end
