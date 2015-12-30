//
//  MagazineCategoryViewController.h
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagazineCategoryViewControllerDelegate <NSObject>

- (void)goBackMagazineCategoryView:(NSString *)url title:(NSString *)title indexPath:(NSIndexPath *)indexPath;

- (void)goBackMagazineCategoryView:(NSString *)url title:(NSString *)title;

@end



@interface MagazineCategoryViewController : UIViewController

@property (nonatomic) NSString *bottonButtonTitle;

@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic,weak) id <MagazineCategoryViewControllerDelegate>delegate;

@end
