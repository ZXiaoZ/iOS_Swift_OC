//
//  ZXZContactGroup.m
//  MyTableView
//
//  Created by zxz on 15/11/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZContactGroup.h"

@implementation ZXZContactGroup

#pragma mark 初始化方法
-(ZXZContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts
{
    self = [super init];
    if (self) {
        self.name = name;
        self.detail=detail;
        self.contacts = contacts;
    }
    
    return self;
}

#pragma mark 静态初始化方法
+(ZXZContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts
{
       ZXZContactGroup *group1=[[ZXZContactGroup alloc]initWithName:name andDetail:detail andContacts:contacts];
    return group1;
}


@end
