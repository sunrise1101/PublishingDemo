//
//  DXDTabBar.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXDTabBar;

@protocol DXDTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(DXDTabBar *)tabBar;
@end

@interface DXDTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<DXDTabBarDelegate> dxdDelegate ;

@end
