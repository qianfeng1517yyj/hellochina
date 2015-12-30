//
//  WQQAuthorModel.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQAuthorModel.h"

@implementation WQQAuthorModel

// 获取作者界面信息
+ (NSArray *)parsingWithRespondData:(id)respndData {
    NSArray *array = [respndData objectForKey:@"data"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        WQQAuthorModel *model = [[WQQAuthorModel alloc] initWithDictionary:dict error:nil];
        [mArray addObject:model];
    }
    return mArray;
}

@end
