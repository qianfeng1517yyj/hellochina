//
//  FetchViewController.h
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FetchViewControllerDelegate <NSObject>

- (void)goBack:(NSString *)url title:(NSString *)title indexPath:(NSIndexPath *)indexPath;

- (void)goBack:(NSString *)url title:(NSString *)title;

@end


@interface FetchViewController : UIViewController

@property (nonatomic,weak) id <FetchViewControllerDelegate> delegate;

- (void)fetchData;

//搭建UI界面
- (void)createUI;

// 获取网络请求连接
- (NSString *)composeRequsetUrl;

// 分析解析数据
- (void)parsingResponsData:(id)responsData;

@property (nonatomic) NSMutableArray *dataSource;

@end
