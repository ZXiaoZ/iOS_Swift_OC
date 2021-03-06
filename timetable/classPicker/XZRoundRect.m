//
//  XZRoundRect.m
//  pickerView
//
//  Created by zxz on 15/12/16.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZRoundRect.h"

@implementation XZRoundRect

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _textLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_textLable];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10.0f];
    [bezierPath setLineWidth:10.0f];
    [RGBColor(204,204,204) setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1]; // color equivalent is #87ceeb
    
    [fillColor setFill];
    
    [bezierPath stroke];
//    [bezierPath fill];
    CGContextRestoreGState(aRef);
}


@end
