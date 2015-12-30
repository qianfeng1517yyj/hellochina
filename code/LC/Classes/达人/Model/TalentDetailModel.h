//
//  TalentDetailModel.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "BaseModel.h"
@interface TalentDetailModel : BaseModel

@property(nonatomic,copy)NSString*user_id;
@property(nonatomic,copy)NSString*user_name;
@property(nonatomic,copy)NSString*is_daren;
@property(nonatomic,copy)NSString*email;
@property(nonatomic,copy)NSString*owner_id;
@property(nonatomic,copy)NSString*user_image;
@property(nonatomic,copy)NSString*user_desc;
@property(nonatomic,copy)NSString*friend;
@property(nonatomic,copy)NSString *template_id;
@property(nonatomic)NSArray *users;
@property(nonatomic)NSArray *goods;



@property(nonatomic,copy)NSString*like_count;
@property(nonatomic,copy)NSString*recommendation_count;
@property(nonatomic,copy)NSString*following_count;
@property(nonatomic,copy)NSString*followed_count;
@end
