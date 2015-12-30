//
//  MJYUserModel.h
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "BaseModel.h"

@interface MJYUserModel : BaseModel

@property (nonatomic,copy)NSString *comment_id;
@property (nonatomic)NSInteger user_id;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *is_daren;
@property (nonatomic,copy)NSString *parent_uid;
@property (nonatomic,copy)NSString *parent_username;
@property (nonatomic,copy)NSString *user_image;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,copy)NSString *user_desc;
@property (nonatomic,copy)NSString *create_time;

@end
