//
//  Help.h
//  BubbleChooseClass
//
//  Created by zxz on 15/12/25.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Help)
/**
 *获取对象的所有属性，不包括属性值
 */
- (NSArray *)getAllProperties;
/**
 *获取对象的所有属性 以及属性值
 */
- (NSDictionary *)properties_aps;
/**
 *获取对象的所有方法
 */
-(void)printMothList;
@end
