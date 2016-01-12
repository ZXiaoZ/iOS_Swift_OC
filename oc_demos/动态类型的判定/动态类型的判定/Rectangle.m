//
//  Rectangle.m
//  Rectangle
//
//  Created by zxz on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle
{
    XYpoint *origin;
}
@synthesize width, height;
-(int) area
{
    return width*height;
}
-(int) perimeter
{
    return (width + height)*2;
}
-(void) setWidth:(int)Width andHeight:(int)Height
{
    width=Width;
    height=Height;
}
-(XYpoint *) origin//原点
{
    return origin;
}
-(void) setOrigin:(XYpoint *)pt
{
    if(!origin)
        origin=[[XYpoint alloc]init];
    origin.x=pt.x;
    origin.y=pt.y;
}
@end
