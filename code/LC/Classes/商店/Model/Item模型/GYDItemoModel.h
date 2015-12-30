//
//  GYDItemoModel.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDItemoModel : NSObject

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_url;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_desc;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *comment_count;
@property (nonatomic, copy) NSString *like_count;
@property (nonatomic, assign) NSInteger liked;
@property (nonatomic, copy) NSString *discount_price;
@property (nonatomic, strong) NSArray *sku_inv;
@property (nonatomic, strong) NSDictionary *brand_info;
@property (nonatomic, assign) BOOL coupon_flag;
@property (nonatomic, assign) NSInteger owner_id;
@property (nonatomic, copy) NSString *owner_name;
@property (nonatomic, copy) NSString *owner_desc;
@property (nonatomic, copy) NSString *is_daren;
@property (nonatomic, copy) NSString *owner_image;
@property (nonatomic, copy) NSString *rec_reason;
@property (nonatomic, strong) NSArray *sku_info;
@property (nonatomic, copy) NSString *is_gift;
@property (nonatomic, assign) NSInteger servicer_id;
@property (nonatomic, copy) NSString *good_ship_rule;
@property (nonatomic, strong) NSDictionary *good_guide;
@property (nonatomic, copy) NSString *promotion_info;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, assign) NSInteger able_buy;
@property (nonatomic, copy) NSString *able_buy_note;
@property (nonatomic, strong) NSArray *images_item;

@end
