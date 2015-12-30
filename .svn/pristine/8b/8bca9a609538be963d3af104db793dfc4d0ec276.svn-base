//
//  ItemModel.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)itemModelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)itemModelList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LCItems" ofType:@"plist"];
    NSArray *items = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *newList = [NSMutableArray array];
    for (NSDictionary *dic in items) {
        ItemModel *itemModel = [ItemModel itemModelWithDic:dic];
        [newList addObject:itemModel];
    }
    return newList;
    
    
}


@end
