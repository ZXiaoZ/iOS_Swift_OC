//
//  XZNumValidator.h
//  classTimeDemo
//
//  Created by zxz on 15/12/22.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZNumValidator : NSObject

-(BOOL)checkIfValid:(NSString *)str WithRegex:(NSString *)regex;
-(NSArray *)extractNumbers:(NSString *)str;
-(NSArray *)extractString:(NSString *)string;

@end
