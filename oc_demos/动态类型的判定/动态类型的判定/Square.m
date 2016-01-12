//
//  Square.m
//  Rectangle
//
//  Created by zxz on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Square.h"

@implementation Square:Rectangle
-(void) setSide:(int)s
{
    [self setWidth:s andHeight:s];
}
-(int) side
{
    return self.width;
}
-(NSString *)print:(NSString *)name
{
    NSLog(@"mySquare is here %@",name);
    return name;
}
@end
