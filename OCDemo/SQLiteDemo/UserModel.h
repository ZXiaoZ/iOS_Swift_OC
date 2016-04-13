//
//  UserModel.h
//  SQLiteDemo
//
//  Created by zxz on 15/12/3.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *age;
@end
