//
//  StoreItemModel.h
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "JSONModel.h"

@protocol StoreItemModelDelegate <NSObject>
@end

@interface StoreItemModel : JSONModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary<Optional> *cover;
@property (nonatomic, strong) NSArray<Optional> *children;
@property (nonatomic, strong) NSNumber *parent_id;
@property (nonatomic, copy) NSString *english_name;
@property (nonatomic, strong) NSNumber *id;

@end
