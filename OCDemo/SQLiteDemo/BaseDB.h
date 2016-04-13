//
//  BaseDB.h
//  SQLiteDemo
//  数据库操作基类
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDB : NSObject
-(NSString *)filePath;
//创建表
-(void)createTable:(NSString *)sql;

/**
 *接口描述:插入数据.删除数据.修改数据
 *参数: sql:SQL语句
 *返回值: 是否执行成功
 *
 */
-(BOOL)dealData:(NSString *)sql paramsArray:(NSArray *)params;

/**
 *接口描述:查询数据
 *参数:  sql:SQL语句
 *返回值: [
            ["字段值1","字段值2","字段值3"],
            ["字段值1","字段值2","字段值3"],
            ["字段值1","字段值2","字段值3"]
         ]
 */
-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number;
@end
