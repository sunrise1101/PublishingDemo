//
//  UIImage+Expand.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import "UIImage+Expand.h"

@implementation UIImage (Expand)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithCaputureView:(UIView *)view {
    CGSize size = CGSizeMake(view.bounds.size.width, view.bounds.size.height);
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    // 生成新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}


@end
