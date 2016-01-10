//
//  XZNumValidator.m
//  classTimeDemo
//
//  Created by zxz on 15/12/22.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZNumValidator.h"

@implementation XZNumValidator


//判断字符串是否合法
-(BOOL)checkIfValid:(NSString *)str WithRegex:(NSString *)regex{
//    NSString *regex = @"^[a-z0－9A-Z]*$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 判断的字符串
    // 对字符串进行判断
    if ([predicate evaluateWithObject:str]) {
        NSLog(@"Match");
        return YES;
    }
    else{
//        NSLog(@"No Match");
        return NO;
    }
}
-(NSArray *)extractString:(NSString *)str{
    NSString *url = @"1229436624@qq.com";
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[^@]*\\."
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:url
                                                        options:0
                                                          range:NSMakeRange(0, [url length])];
        if (match) {
            // 截获特定的字符串
            NSString *result = [url substringWithRange:match.range];
            NSLog(@"%@",result);
        }
    } else { // 如果有错误，则把错误打印出来
        NSLog(@"error - %@", error);
    }
    return [NSArray new];
}

-(NSArray *)extractNumbers:(NSString *)string{
    NSString *regex = @"\\-\\d*\\.";
    NSString *str = @"-34023242.-34203020.";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex
                                                                             options:NSRegularExpressionCaseInsensitive
                                                                               error:&error];
    // 对str字符串进行匹配
    NSArray *matches = [regular matchesInString:str
                                        options:0
                                          range:NSMakeRange(0, str.length)];
    // 遍历匹配后的每一条记录
    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        NSString *mStr = [str substringWithRange:range];
        NSLog(@"%@", mStr);
    }
    return [NSArray new];
}


@end
