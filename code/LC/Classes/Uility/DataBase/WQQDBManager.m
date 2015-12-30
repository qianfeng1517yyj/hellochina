//
//  WQQDBManager.m
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQDBManager.h"
#import "FMDatabase.h"

@interface WQQDBManager ()
{
    FMDatabase *_db;// 数据库实例
}

@end
@implementation WQQDBManager

+ (instancetype)sharedInstance {
    static WQQDBManager *s_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[WQQDBManager alloc] init];
    });
    return s_manager;
}
// 获取存储路径
- (NSString *)dbPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LC.db"];
}

- (id)init {
    if (self = [super init]) {
        _db  = [[FMDatabase alloc]initWithPath:[self dbPath]];
        if ([_db open]) {
            [self createTable];
        }
    }
    return self;
}

- (void)createTable {
    NSString *sql = @"create table if not exists modelInfo(taid text primary key,topic_name text,topic_url text,cover_img_new text,addtime text,nav_title text,author_name text,cat_name text)";
    if (![_db executeUpdate:sql]) {
        
    }
}

// 添加
- (void)addManagerModelInfo:(WQQMagazineModel *)model {
    NSString *sql = @"insert into modelInfo(taid,topic_name,topic_url,cover_img_new,addtime,nav_title,author_name,cat_name) values(?,?,?,?,?,?,?,?)";
    NSDate *date = [NSDate date];
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strDate = [fmt stringFromDate:date];
    if (![_db executeUpdate:sql,model.taid,model.topic_name,model.topic_url,model.cover_img_new,strDate,model.nav_title,model.author_name,model.cat_name]) {
       
    }

}

// 删除
- (void)deleteManagerModelInfo:(WQQMagazineModel *)model {
    NSString *sql = @"delete from modelInfo where taid = ?";
    if (![_db executeUpdate:sql,model.taid]) {
       
    }
}

// 读取数据库所有信息
- (NSArray *)readManagerModelInfoList {
    NSMutableArray *modelArray = [NSMutableArray array];
    NSString *sql = @"select *from modelInfo";
    FMResultSet *resultSet = [_db executeQuery:sql];
    while (resultSet.next) {
        WQQMagazineModel *model = [[WQQMagazineModel alloc] init];
        model.taid              = [resultSet stringForColumn:@"taid"];
        model.topic_url         = [resultSet stringForColumn:@"topic_url"];
        model.topic_name        = [resultSet stringForColumn:@"topic_name"];
        model.cover_img_new     = [resultSet stringForColumn:@"cover_img_new"];
        model.addtime           = [resultSet stringForColumn:@"addtime"];
        model.nav_title         = [resultSet stringForColumn:@"nav_title"];
        model.author_name       = [resultSet stringForColumn:@"author_name"];
        model.cat_name          = [resultSet stringForColumn:@"cat_name"];
        [modelArray addObject:model];
    }
    [resultSet close];
    return modelArray;

}

// 判断该模型是否存在
- (BOOL)isManaegrExists:(WQQMagazineModel *)model {
    BOOL isExist = NO;
    NSString *sql = @"select * from modelInfo where taid = ?";
    FMResultSet *resultSet = [_db executeQuery:sql,model.taid];
    if (resultSet.next) {
        isExist = YES;
    }
    [resultSet close];
    return isExist;
}


@end
