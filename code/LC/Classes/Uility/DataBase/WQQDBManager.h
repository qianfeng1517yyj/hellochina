//
//  WQQDBManager.h
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQQMagazineModel.h"
@interface WQQDBManager : NSObject

+ (instancetype)sharedInstance;

// 添加
- (void)addManagerModelInfo:(WQQMagazineModel *)model;

// 删除
- (void)deleteManagerModelInfo:(WQQMagazineModel *)model;

// 读取数据库所有信息
- (NSArray *)readManagerModelInfoList;

// 判断该模型是否存在
- (BOOL)isManaegrExists:(WQQMagazineModel *)model;

@end
