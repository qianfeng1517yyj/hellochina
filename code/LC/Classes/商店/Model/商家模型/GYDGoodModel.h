//
//  GYDGoodModel.h
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDGoodModel : NSObject
@property (nonatomic, strong) NSDictionary *sku;
@property (nonatomic, assign) BOOL is_gift;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL is_liked;
@property (nonatomic, copy) NSString *discount_price;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger brand_id;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, copy) NSString *sale_by;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *name;
@end
