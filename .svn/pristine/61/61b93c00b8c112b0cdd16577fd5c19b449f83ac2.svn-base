//
//  FetchViewController.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "FetchViewController.h"

@interface FetchViewController ()

@end

@implementation FetchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
}
#pragma mark -
#pragma mark 创建界面
- (void)createUI {

}

#pragma mark -
#pragma mark 网络请求
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}
- (BOOL)fetchDataFromLocal {
    return NO;
}
- (void)fetchDataFromServer {
    NSString *url = [self composeRequsetUrl];
    [[NetDataEngine sharedInstance] requsetMagazineFrom:url success:^(id responsData) {
        [self parsingResponsData:responsData];
    } failed:^(NSError *error) {
       
    }];
}

- (void)parsingResponsData:(id)responsData {
}

- (NSString *)composeRequsetUrl {
    return LCMagazineUrl;
}

@end
