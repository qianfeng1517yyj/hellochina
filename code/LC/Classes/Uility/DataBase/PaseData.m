//
//  PaseData.m
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "PaseData.h"
#import "StoreItemModel.h"
#import "TalentShowModel.h"
#import "WQQMagazineModel.h"
#import "GYDStoreDetailModel.h"
#import "TalentDetailModel.h"
#import "StoreHeadModel.h"
#import "GYDShopModel.h"
#import "GYDGoodModel.h"
@implementation PaseData

/**
*  解析杂志主页数据
*/
+ (NSDictionary *)paseMagazineData:(id)data{
    NSDictionary *dic = [data objectForKey:@"data"];
    NSArray *dataKey = [dic objectForKey:@"keys"];
    NSDictionary *dataSource = [dic objectForKey:@"infos"];
    NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
    for (NSString *obj in dataKey) {
        NSArray *arr = [dataSource objectForKey:obj];
        NSMutableArray *mall = [NSMutableArray array];
        for (NSDictionary *subDic in arr) {
            WQQMagazineModel *model = [[WQQMagazineModel alloc] initWithDictionary:subDic error:nil];  
            [mall addObject:model];
        }
        [allDic setValue:mall forKey:obj];
    }
    return allDic;
}

+ (NSArray *)paseMagazieData:(id)data {
    NSDictionary *dic = [data objectForKey:@"data"];
    NSArray *dataKey = [dic objectForKey:@"keys"];
    return dataKey;
}


/**
 *  解析商店主页数据
 */
+ (NSMutableArray *)paseStoreData:(id)data {
    NSDictionary *rootDic = [((NSDictionary *)data) objectForKey:@"data"];
    NSArray *arr = [rootDic objectForKey:@"items"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        NSMutableArray *tmpArr2 = [NSMutableArray array];
        StoreItemModel *model = [[StoreItemModel alloc] initWithDictionary:dic error:nil];
        for (NSDictionary *dic2 in model.children) {
            StoreItemModel *model2 = [[StoreItemModel alloc] initWithDictionary:dic2 error:nil];
            [tmpArr2 addObject:model2];
        }
        model.children = tmpArr2;
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析商店主页数据
 */
+ (NSMutableArray *)paseStoreHeadData:(id)data {
    NSDictionary *dic = [(NSDictionary *)data objectForKey:@"data"];
    NSArray *arr = [dic objectForKey:@"items"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        StoreHeadModel *model = [[StoreHeadModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析商店商家数据
 */
+ (NSMutableArray *)paseShopData:(id)data {
    NSDictionary *dic = [(NSDictionary *)data objectForKey:@"data"];
    NSArray *arr = [dic objectForKey:@"items"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        GYDShopModel *model = [[GYDShopModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析商店商家Item数据
 */
+ (NSMutableArray *)paseShopGoodData:(id)data {
    NSDictionary *dic = [(NSDictionary *)data objectForKey:@"data"];
    NSArray *arr = [dic objectForKey:@"goods"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        GYDGoodModel *model = [[GYDGoodModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析商店详情页数据
 *
 */
+ (NSArray *)paseStoreDetailData:(id)data {
    NSArray *rootArr = [((NSDictionary *)data) objectForKey:@"data"];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in rootArr) {
        GYDStoreDetailModel *model = [[GYDStoreDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析商店Item详情数据
 */
+ (GYDItemoModel *)paseStoreItemDetailData:(id)data {
    NSDictionary *rootDic = [((NSDictionary *)data) objectForKey:@"data"];
    GYDItemoModel *model = [[GYDItemoModel alloc] init];
    [model setValuesForKeysWithDictionary:rootDic];
    return model;
}
/**
 *  解析搜索商品结果
 */
+ (NSArray *)paseSearchGoodData:(id)data {
    NSArray *arr = [(NSDictionary *)data objectForKey:@"data"];
    if (arr == nil) {
        return nil;
    }
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        MJYShareModel *model = [[MJYShareModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tmpArr addObject:model];
    }
    return tmpArr;
}
/**
 *  解析分享主页数据
 */
+ (NSMutableArray *)paseShareData:(id)data {
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSDictionary *dic in data[@"data"]) {
        MJYShareModel *model = [[MJYShareModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [dataSource addObject:model];
    }
    return dataSource;
    
}

/**
 *  解析分享主页详情数据
 */
//解析分享主页详情数据 上
+ (MJYShareModel *)paseShareUpDetailData:(id)data {
    
    MJYShareModel *model = [[MJYShareModel alloc]init];
    [model setValuesForKeysWithDictionary:data[@"data"]];
    return model;
}

+ (NSMutableArray *)paseShareDownDetailData:(id)data {
    
    NSMutableArray *dataSource = [NSMutableArray array];
    NSDictionary *dataDic = data[@"data"];
    if ([dataDic[@"items"] isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSArray *dataArr = dataDic[@"items"];
    for (NSDictionary *dic in dataArr) {
        MJYUserModel *model = [[MJYUserModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [dataSource addObject:model];
    }
    return dataSource;
}

//达人数据解析
+ (TalentDetailModel *)paseTalentHeardData:(id)data {
    NSDictionary *dict = data[@"data"];
    TalentDetailModel *model =[[TalentDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

+ (NSMutableArray *)paseTalentData:(id)data {
    NSMutableArray *array =[NSMutableArray array];
    NSArray * dataArray = data[@"data"];
    for (NSDictionary *dic in dataArray) {
        TalentShowModel *model =[[TalentShowModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
+ (NSMutableArray *)paseTalentDetailData:(id)data {
    NSMutableArray *array =[NSMutableArray array];
    NSDictionary *dict = data[@"data"];
    NSArray *arr =dict[@"goods"];
    for (NSDictionary *dic in arr) {
        MJYShareModel *model =[[MJYShareModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}
+ (NSMutableArray *)paseTalentFocusData:(id)data {
    NSMutableArray *array =[NSMutableArray array];
    NSDictionary *dict = data[@"data"];
    NSArray *arr =dict[@"users"];
    for (NSDictionary *dic in arr) {
        TalentShowModel *model =[[TalentShowModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
