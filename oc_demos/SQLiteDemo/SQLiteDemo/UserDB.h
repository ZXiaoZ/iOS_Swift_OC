//
//  UserDB.h
//  SQLiteDemo
//
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface UserDB : NSObject
//创建数据库,只创建一次
-(void)createTable;
//插入数据
-(void)insertTable;
//查询数据
-(void)selectTable;
@end
