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
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key, password TEXT,age TEXT)";
    [self createTable:sql];
}

-(BOOL)addUser:(UserModel *)userModel {
    NSString *sql = @"INSERT INTO User (username,password,age) VALUES(?,?,?)";
    
    NSArray *params = [NSArray arrayWithObjects:userModel.username,
                                              userModel.password,
                                                userModel.age,nil];
    return [self dealData:sql paramsArray:params];
}

-(NSArray *)findUsers {
    NSString *sql = @"SELECT username,password,age FROM User";
    NSArray *data = [self selectData:sql columns:3];
    
    NSMutableArray *users = [NSMutableArray array];
    for (NSArray *row in data) {
        NSString *username= [row objectAtIndex:0];
        NSString *password = [row objectAtIndex:1];
        NSString *age = [row objectAtIndex:2];
        
        UserModel *user = [[UserModel alloc]init];
        user.username = username;
        user.password = password;
        user.age = age;
        [users addObject:user ];
    }
    return users;
}
@end
