//
//  UserDB.m
//  SQLiteDemo
//
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "UserDB.h"

@implementation UserDB

-(void)createTable{
    sqlite3 *sqlite = nil;
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
//    NSLog(@"%@",filePath);
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result !=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }
    //创建表的SQL语句
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key, password TEXT,email TEXT)";
    char *error;
    result = sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &error);
    if (result !=SQLITE_OK) {
        NSLog(@"创建表失败: %s",error);
        return;
    }
    //关闭数据库
    sqlite3_close(sqlite );
}

-(void)insertTable {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库,如果filePath存在,则打开,不存在则创建
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    //    NSLog(@"%@",filePath);
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result !=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    //创建SQL语句
    NSString *sql = @"INSERT INTO User (username,password,email) VALUES(?,?,?)";
    //编译sql语句
    sqlite3_prepare_v2(sqlite , [sql UTF8String], -1, &stmt, NULL);
    NSString *username = @"jack";
    NSString *password = @"1234";
    NSString *email = @"1230@qq.com";
    //往sql语句中绑定数据,第二个参数为索引
    sqlite3_bind_text(stmt, 1, [username UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 3, [email UTF8String], -1, NULL);
    //执行sql语句
    result = sqlite3_step(stmt);
    if (result ==SQLITE_ERROR ||result == SQLITE_MISUSE) {
        NSLog(@"执行sql语句失败");
        return;
    }
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    //关闭数据库
    sqlite3_close(sqlite );
    NSLog(@"数据插入成功");
}

-(void)selectTable{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;

    //打开数据库,如果filePath存在,则打开,不存在则创建
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    //    NSLog(@"%@",filePath);
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result !=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }
    //数据库语句
    NSString *sql = @"SELECT username,password,email FROM User WHERE username=?";
    //编译sql语句
    result = sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result !=SQLITE_OK) {
        NSLog(@"sql语句编译失败");
        return;
    }
    NSString *username = @"jack";
    sqlite3_bind_text(stmt, 1, [username UTF8String], -1, NULL);//绑定username
    
    //查询数据
    result =  sqlite3_step(stmt);
    while (result == SQLITE_ROW) {
        char *username= (char *)sqlite3_column_text(stmt, 0);//索引从0开始
        char *password= (char *)sqlite3_column_text(stmt, 1);
        char *email= (char *)sqlite3_column_text(stmt, 2);
        
        NSString *userNameString = [NSString stringWithCString:username encoding:NSUTF8StringEncoding];
        NSString *passwordString = [NSString stringWithCString:password encoding:NSUTF8StringEncoding];
        NSString *emailString = [NSString stringWithCString:email encoding:NSUTF8StringEncoding];
        NSLog(@"----用户名:%@,密码:%@,邮箱:%@----",userNameString,passwordString,emailString);
        //跳到下一个数据
        result = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite );
}
@end
