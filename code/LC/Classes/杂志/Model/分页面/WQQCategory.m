//
//  WQQCategory.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQCategory.h"

@implementation WQQCategory

// 获取作者界面信息
+ (NSArray *)parsingWithRespondData:(id)respndData {
     NSArray *array  = [respndData objectForKey:@"data"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        WQQCategory *model = [[WQQCategory alloc] initWithDictionary:dict error:nil];
        [mArray addObject:model];
    }
    return mArray;
}

@end
