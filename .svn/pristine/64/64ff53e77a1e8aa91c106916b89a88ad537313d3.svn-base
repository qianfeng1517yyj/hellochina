//
//  NavigationViewController.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
/**
 * 定制UINavigationBar
 */
+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.backgroundColor = [UIColor clearColor];
    [navigationBar setBackgroundImage:[UIImage imageWithOriginal:@"bg_nav_bar"] forBarMetrics:UIBarMetricsDefault];
    navigationBar.translucent = NO;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:[UIColor whiteColor],
                                            NSFontAttributeName:[UIFont systemFontOfSize:20],
                                            NSShadowAttributeName:shadow
                                            }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  拦截push
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        UIView *view = [self.tabBarController.view viewWithTag:10000];
        view.hidden = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
