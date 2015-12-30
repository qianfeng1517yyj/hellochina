//
//  StoreSectionView.h
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItemModel.h"
//类型声明
typedef void(^ClickBlockType) (NSInteger tag);

@interface StoreSectionView : UIView

@property NSUInteger section;
@property (nonatomic, weak) UITableView *tableView;

//定义变量
@property(nonatomic,copy)ClickBlockType block;
- (void)updateWithModel:(StoreItemModel *)model;

@end
