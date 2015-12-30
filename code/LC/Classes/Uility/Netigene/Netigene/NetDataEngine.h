//
//  NetDataEngine.h
//  你知道么
//
//  Created by QianFeng on 15/9/19.
//  Copyright (c) 2015年 王启启. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlockType) (id responsData);
typedef void(^FailedBlockType)  (NSError *error);

@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;

// 杂志
- (void)requsetMagazineFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
// 商店
- (void)requsetStoreFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
// 分享
- (void)requsetShareFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
// 达人
- (void)requsetTalentShowFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

@end
