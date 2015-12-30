//
//  GYDShopModel.h
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDShopModel : NSObject


@property (nonatomic, strong) NSDictionary *category;
@property (nonatomic, strong) NSDictionary *logo;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger id;

@end
