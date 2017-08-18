//
//  XYBoughtCacheTool.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#import "XYBoughtCacheTool.h"
#import "FMDB.h"

@implementation XYBoughtCacheTool


// 声明一个只有本文件能用的数据库全局队列
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    DLog(@"%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, status blob);"];
    }];
}

+ (void)add:(XYSurveyCache *)cache
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cache];  // 这里的意思是Status必须实现Coding协议
        
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"insert into t_status (status) values(?)", data];
        if (isSuccess) {
            DLog(@"保存成功");
        }
    }];

}

+ (NSArray <XYSurveyCache *>*)caches
{
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:@"select * from t_status"];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"status"];
            XYSurveyCache *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    
    // 3.返回数据
    return statusArray;
}

@end
