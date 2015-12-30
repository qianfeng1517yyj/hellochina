//
//  PaseData.h
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJYUserModel.h"
#import "MJYShareModel.h"
#import "GYDItemoModel.h"
#import "TalentDetailModel.h"
@interface PaseData : NSObject


/**
 *  解析杂志主页数据
 */
+ (NSArray *)paseMagazieData:(id)data;
+ (NSDictionary *)paseMagazineData:(id)data;

/**
 *  解析商店主页数据
 */
+ (NSMutableArray *)paseStoreData:(id)data;
/**
 *  解析商店主页数据
 */
+ (NSMutableArray *)paseStoreHeadData:(id)data;
/**
 *  解析商店商家数据
 */
+ (NSMutableArray *)paseShopData:(id)data;
/**
 *  解析商店商家Item数据
 */
+ (NSMutableArray *)paseShopGoodData:(id)data;
/**
 *  解析商店详情页数据
 *
 */
+ (NSArray *)paseStoreDetailData:(id)data;
/**
 *  解析商店Item详情数据
 */
+ (GYDItemoModel *)paseStoreItemDetailData:(id)data;
/**
 *  解析搜索商品结果
 */
+ (NSArray *)paseSearchGoodData:(id)data;

/**
 *  解析分享主页详情数据
 */
//解析分享主页详情数据 上
+ (MJYShareModel *)paseShareUpDetailData:(id)data;
// 解析分享主页详情数据 下
+ (NSMutableArray *)paseShareDownDetailData:(id)data;
/**
 *  解析分享主页数据
 */
+ (NSMutableArray *)paseShareData:(id)data;
/**
 *  解析达人主页数据
 */
+ (TalentDetailModel *)paseTalentHeardData:(id)data;
+ (NSMutableArray *)paseTalentData:(id)data;
//解析达人二级界面推荐
+ (NSMutableArray*)paseTalentDetailData:(id)data;
//解析达人二级界面关注
+ (NSMutableArray*)paseTalentFocusData:(id)data;


@end
