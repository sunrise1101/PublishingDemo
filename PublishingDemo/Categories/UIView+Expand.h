//
//  UIView+Expand.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Expand)

@property(nonatomic, assign)CGFloat      width;
@property(nonatomic, assign)CGFloat      height;
@property(nonatomic, assign)CGFloat      originX;
@property(nonatomic, assign)CGFloat      originY;
@property(nonatomic, assign)CGFloat      centerX;
@property(nonatomic, assign)CGFloat      centerY;
@property(nonatomic, assign)CGPoint      origin;
@property(nonatomic, assign)CGSize       size;

@property(nonatomic,readonly)CGFloat      maxX;
@property(nonatomic,readonly)CGFloat      maxY;

@end
