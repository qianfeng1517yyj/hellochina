//
//  GYDStoreDetailModel.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDStoreDetailModel : NSObject

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *owner_id;
@property (nonatomic, copy) NSString *comment_count;
@property (nonatomic, copy) NSString *like_count;
@property (nonatomic, assign) NSInteger liked;
@property (nonatomic, copy) NSString *sale_by;
@property (nonatomic, copy) NSString *goods_url;
@property (nonatomic, assign) NSInteger is_gift;
@property (nonatomic, copy) NSString *discount_price;
@property (nonatomic, assign) BOOL coupon_flag;
@property (nonatomic, copy) NSString *promotion_imgurl;
@property (nonatomic, strong) NSDictionary *brand_info;

@end
