//
//  ZXZContact.h
//  MyTableView
//
//  Created by zxz on 15/11/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXZContact : NSObject

#pragma mark 姓 名 手机号
@property (nonatomic,copy) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSString *phoneNumber;

#pragma mark 带参数的构造函数
-(ZXZContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

#pragma mark 取得姓名
-(NSString *)getName;


#pragma mark 带参数的静态对象初始化方法
+(ZXZContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

@end
