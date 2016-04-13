//
//  UserDB.h
//  SQLiteDemo
//
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "BaseDB.h"
#import "UserModel.h"

@interface UserDB : BaseDB
//创建用户表
-(void)createTable;
//添加用户
-(BOOL)addUser:(UserModel *)userModel;
//查询用户
-(NSArray *)findUsers;
@end
