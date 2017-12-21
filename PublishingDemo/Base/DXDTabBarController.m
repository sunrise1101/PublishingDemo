//
//  DXDTabBarController.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import "DXDTabBarController.h"
#import "DXDTabBar.h"
#import "PublishingViewController.h"
#import "TestViewController.h"

@interface DXDTabBarController () <DXDTabBarDelegate>

@end

@implementation DXDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    DXDTabBar *tabbar = [[DXDTabBar alloc] init];
    tabbar.dxdDelegate = self;
    //kvc实质是修改了系统的_tabBargit
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    // Do any additional setup after loading the view.
    [self customTabbarVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 自定义tabbarController结构及UI
 */
- (void)customTabbarVC {
    //base custom
    NSArray *namesArr = @[@"OneViewController", @"TwoViewController",@"ThreeViewController", @"FourViewController"];
    NSArray *titlesArr = @[@"首页", @"用户",@"管理", @"我的"];
    NSArray *nImagesArr = @[@"ic_homepage_s", @"ic_patient_s", @"ic_serve_unpress", @"ic_my_s"];
    NSArray *sImagesArr = @[@"ic_homepage", @"ic_patient", @"ic_serve_press", @"ic_my"];
    
    
    //init controllers
    NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:namesArr.count];
    for (int i = 0; i < namesArr.count; i++) {
        UIViewController *VC = [[NSClassFromString(namesArr[i]) alloc] init];
        VC.title = titlesArr[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        nav.tabBarItem.image = [UIImage imageNamed:nImagesArr[i]];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:sImagesArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor pb_colorWithHexString:c_warmGrey]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor pb_colorWithHexString:c_grapefruit]} forState:UIControlStateSelected];
        [itemArr addObject:nav];
    }
    
    //set tabbar
    self.viewControllers = itemArr;
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - DXTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(DXDTabBar *)tabBar {
    PublishingViewController *vc = [[PublishingViewController alloc] init];
    //虚化背景
    UIImage *image = [UIImage imageWithCaputureView:self.view];
    vc.backImg = image;
    @weakify(self);
    vc.dismissVC = ^(NSInteger tag) {
        @strongify(self);
        [self goTestVCWithTag:tag];
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)goTestVCWithTag:(NSInteger)tag {
    TestViewController *vc = [[TestViewController alloc] init];
    vc.tag = tag;
    vc.hidesBottomBarWhenPushed = YES;
    [self.selectedViewController pushViewController:vc animated:YES];
}

@end
