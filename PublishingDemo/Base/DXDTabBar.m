//
//  DXDTabBar.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import "DXDTabBar.h"
#import <UIKit/UIKit.h>
#import "UIMacros.h"
#import "UIView+Expand.h"
#import "UIImage+Expand.h"
#import "UIColor+Expand.h"

@interface DXDTabBar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation DXDTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //        ----runtime - test----
        
        //        unsigned int count = 0;
        //        Ivar *ivarList = class_copyIvarList([UITabBar class], &count);
        //        for (int i =0; i<count; i++) {
        //            Ivar ivar = ivarList[i];
        //            LBLog(@"%s",ivar_getName(ivar));
        //        }
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, PBSCREEN_WIDTH, self.height)];
        [imageView setImage:[UIImage imageNamed:@"ic_tabbar_backimage"]];
        [imageView setContentMode:UIViewContentModeCenter];
        [self insertSubview:imageView atIndex:0];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_ issue_services"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_ issue_services"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        
        plusBtn.center = CGPointMake(PBSCREEN_WIDTH / 2 - plusBtn.currentBackgroundImage.size.width/2, self.height * 0.5 - Magin);
        plusBtn.size = CGSizeMake(plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
        self.plusBtn = plusBtn;
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"服务市场";
        label.font = PBSysFont(10);
        [label sizeToFit];
        label.textColor = [UIColor pb_colorWithHexString:c_warmGrey];
        [self addSubview:label];
        
        label.center = CGPointMake(plusBtn.centerX, CGRectGetMaxY(plusBtn.frame) + Magin * 1.6);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 5;
            
            btn.originX = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.dxdDelegate tabBarPlusBtnClick:self];
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
