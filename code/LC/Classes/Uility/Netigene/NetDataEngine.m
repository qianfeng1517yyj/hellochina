//
//  NetDataEngine.m
//  你知道么
//
//  Created by QianFeng on 15/9/19.
//  Copyright (c) 2015年 王启启. All rights reserved.
//

#import "NetDataEngine.h"
#import "AFHTTPRequestOperationManager.h"
@interface NetDataEngine ()
@property (nonatomic) AFHTTPRequestOperationManager *manager;
@property (nonatomic,copy) FailedBlockType failedBlock;
@end

@implementation NetDataEngine


+ (instancetype)sharedInstance {
    static NetDataEngine *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!s_manager) {
            s_manager = [[NetDataEngine alloc] init];
        }
    });
    
    return s_manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPRequestOperationManager alloc] init];
        // 添加新的text/html
        NSSet *set =_manager.responseSerializer.acceptableContentTypes;
        NSMutableSet *mset = [NSMutableSet setWithSet:set];
        [mset addObject:@"text/html"];
        self.manager.responseSerializer.acceptableContentTypes = mset;
    }
    return self;
}

- (void)get:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)startNetDataEngine {
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            default:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
        }
    }];
}
// 杂志页面
- (void)requsetMagazineFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url success:successBlock failed:failedBlock];
}

// 商店
- (void)requsetStoreFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url success:successBlock failed:failedBlock];
}

// 分享
- (void)requsetShareFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url success:successBlock failed:failedBlock];
}

// 达人
- (void)requsetTalentShowFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url success:successBlock failed:failedBlock];
}


@end
