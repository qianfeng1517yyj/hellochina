//
//  CustomTabBarViewController.m
//  CustomTabBarController
//
//  Created by lijinghua on 15/8/19.
//  Copyright (c) 2015年 lijinghua. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "ItemModel.h"
#import "UIViewController+TabBarItem.h"
#import "NavigationViewController.h"

@interface CustomTabBarViewController ()
@property (nonatomic) NSArray *items;
@property (nonatomic) UIButton *lastButton;

@end

@implementation CustomTabBarViewController



- (NSArray *)items {
    if (!_items) {
        _items = [ItemModel itemModelList];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)createContentViewControllers
{
    for (ItemModel *model in self.items) {
        UIViewController *viewController = [NSClassFromString(model.className) viewContrllerTitle:model.title normalImage:model.normalImage selectImageName:model.selectedImage];
        NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
}

- (void)customTabBar
{
    //把自己的tabBar栏隐藏
    [self.tabBar setHidden:YES];
    
    //使用UIImageView充当我们的背景
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, LCKScreenHeight-LCTabBarHeight, LCKScreenWidth, LCTabBarHeight)];
    backgroundView.tag = 10000;
    backgroundView.backgroundColor = LCBaseColor;
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];
    
    CGFloat buttonWidth = LCKScreenWidth/4;
    CGFloat buttonHeight = LCTabBarHeight;
    for (int index = 0; index < 4;index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        ItemModel *model = self.items[index];
        NSString *normalImageName = model.normalImage;
        NSString *selectImageName = model.selectedImage;
        //设置button上的字体的大小
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        button.frame = CGRectMake(index*buttonWidth, 0, buttonWidth, buttonHeight);
        
        button.tag = 100 + index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置初始显示时选中第一个按钮
        if (index == 0) {
            button.selected = YES;
            self.lastButton = button;
        }
        [backgroundView addSubview:button];
    }
}


- (void)buttonClick:(UIButton*)button
{
    self.lastButton.selected = NO;
    //让button处于select状态
    button.selected = YES;
    //修改UITabBarControler的selectedIndex ，会导致切换到对应的页面
    NSInteger index = button.tag - 100;
    self.selectedIndex = index;
    self.lastButton = button;
}



@end
