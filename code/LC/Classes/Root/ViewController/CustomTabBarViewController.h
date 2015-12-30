//
//  CustomTabBarViewController.h
//  CustomTabBarController
//
//  Created by lijinghua on 15/8/19.
//  Copyright (c) 2015年 lijinghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarViewController : UITabBarController

//创建tabbar上使用的内容controllers
- (void)createContentViewControllers;

//自定义我们的一个tabBar
- (void)customTabBar;

@end
