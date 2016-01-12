//
//  BaseDB.m
//  SQLiteDemo
//
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "BaseDB.h"
#define kFilename  @"data.sqlite"

@implementation BaseDB
-(NSString *)filePath{
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",kFilename];
    return filePath;
}
-(void)createTable:(NSString *)sql{
    sqlite3 *sqlite = nil;
    //open sqlite
    if (sqlite3_open([self.filePath UTF8String], &sqlite ) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite );
        return;
    }
    //创建表
    char *errmsg;
    if (sqlite3_exec(sqlite , [sql UTF8String], NULL, NULL, &errmsg) !=SQLITE_OK)
    {
        NSLog(@"创建失败:%s",errmsg);
        sqlite3_close(sqlite );
    }
    
    //关闭数据库
    sqlite3_close(sqlite );
}
/**
 *接口描述:插入数据.删除数据.修改数据
 *参数: sql:SQL语句
 *返回值: 是否执行成功
 *
 */
//INSERT INTO User(username,password,email) values(?,?,?)
-(BOOL)dealData:(NSString *)sql paramsArray:(NSArray *)params{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    //open sqlite
    if (sqlite3_open([self.filePath UTF8String], &sqlite ) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite );
        return NO;
    }
    //编译sql语句
    if (sqlite3_prepare(sqlite , [sql UTF8String], -1, &stmt, NULL) !=SQLITE_OK) {
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite );
        return NO;
    }
    //绑定数据
    for (int i =0; i <params.count; i++) {
        NSString *value = [params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(stmt) == SQLITE_ERROR) {
        NSLog(@"SQL语句执行失败");
        sqlite3_close(sqlite );
        return NO;
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite );
    return YES;
}
/**
 *接口描述:查询数据
 *参数:  sql:SQL语句
 *返回值: [
 ["字段值1","字段值2","字段值3"],
 ["字段值1","字段值2","字段值3"],
 ["字段值1","字段值2","字段值3"]
 ]
 */
//SELECT username,password,email FROM User
-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    //open sqlite
    if (sqlite3_open([self.filePath UTF8String], &sqlite ) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite );
        return nil;
    }
    //编译SQL语句
    if (sqlite3_prepare(sqlite , [sql UTF8String], -1, &stmt, NULL) !=SQLITE_OK) {
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite );
        return nil;
    }
    int result = sqlite3_step(stmt);
    NSMutableArray *data = [NSMutableArray array];
    while (result== SQLITE_ROW) {
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:3];
        for (int i=0; i<number; i++) {
            char *columnText = (char *) sqlite3_column_text(stmt, i);
            NSString *string = [NSString stringWithCString:columnText encoding:NSUTF8StringEncoding];
            [row addObject:string];
        }
        [data addObject:row];
        result = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite );
    return  data;

}


@end
