//
//  ZXZContactGroup.h
//  MyTableView
//
//  Created by zxz on 15/11/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXZContact.h"

@interface ZXZContactGroup : NSObject
#pragma mark 组名 描述 联系人 
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,strong) NSMutableArray* contacts;

#pragma mark 初始化方法
-(ZXZContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

#pragma mark 静态初始化方法
+(ZXZContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

@end
