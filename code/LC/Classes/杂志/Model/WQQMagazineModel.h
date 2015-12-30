//
//  WQQMagazineModel.h
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "JSONModel.h"

@interface WQQMagazineModel : JSONModel

@property (nonatomic,copy) NSString *taid;
@property (nonatomic,copy) NSString *topic_name;
@property (nonatomic,copy) NSString *cat_id;
@property (nonatomic,copy) NSString *author_id;
@property (nonatomic,copy) NSString *topic_url;
@property (nonatomic,copy) NSString *access_url;
@property (nonatomic,copy) NSString *cover_img;
@property (nonatomic,copy) NSString *cover_img_new;
@property (nonatomic)      NSNumber *hit_number;
@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *nav_title;
@property (nonatomic,copy) NSString *author_name;
@property (nonatomic,copy) NSString *cat_name;

@end
