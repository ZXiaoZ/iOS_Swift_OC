//
//  ZXZContact.m
//  MyTableView
//
//  Created by zxz on 15/11/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZContact.h"

@implementation ZXZContact


#pragma mark 带参数的构造函数
-(ZXZContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

#pragma mark 取得姓名
-(NSString *)getName
{
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName ];
}


#pragma mark 带参数的静态对象初始化方法
+(ZXZContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber
{
    ZXZContact *contact1 = [[ZXZContact alloc] initWithFirstName:firstName andLastName:lastName andPhoneNumber:phoneNumber];
    return contact1;
}

@end
