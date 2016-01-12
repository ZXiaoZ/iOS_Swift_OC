//
//  Rectangle.h
//  Rectangle
//
//  Created by zxz on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYpoint.h" 
@interface Rectangle : NSObject
@property (nonatomic)int width, height;
-(XYpoint *) origin;
-(int) area;
-(int) perimeter;
-(void) setWidth:(int)width andHeight:(int)height;
-(void) setOrigin:(XYpoint *)pt;//使每个矩形有不同的原点,创建副本

@end
