//
//  PublishingViewController.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/21.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishingViewController : UIViewController

/**需要模糊效果的图片*/
@property(nonatomic, strong) UIImage *backImg;
@property (nonatomic, copy) void (^dismissVC)(NSInteger tag);

@end
