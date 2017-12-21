//
//  UIImage+Expand.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Expand)

+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  截图功能，根据尺寸截取view成为一张图片
 *
 *  @param view 需要截取的View
 *
 *  @return 新生成的已截取的图片
 */
+(UIImage *)imageWithCaputureView:(UIView *)view;

@end
