//
//  Square.h
//  Rectangle
//
//  Created by zxz on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rectangle.h"
@interface Square :Rectangle
-(void) setSide: (int) s;
-(int) side;
-(NSString *)print:(NSString *)name;
@end
