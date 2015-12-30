//
//  ItemModel.h
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "BaseModel.h"

@interface ItemModel : BaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *normalImage;
@property (nonatomic,copy) NSString *selectedImage;

- (id)initWithDic:(NSDictionary *)dic;

+ (instancetype)itemModelWithDic:(NSDictionary *)dic;

+ (NSArray *)itemModelList;

@end
