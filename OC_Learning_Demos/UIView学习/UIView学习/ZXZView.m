//
//  ZXZView.m
//  UIView学习
//
//  Created by zxz on 15/11/13.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZView.h"

@interface ZXZView()
@property (nonatomic,strong)UIColor *circleColor;

@end
@implementation ZXZView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.circleColor = [UIColor greenColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
        CGRect bounds = rect;
        CGPoint center;
        center.x = bounds.size.width/2;
        center.y = bounds.size.height/2;
        float maxRadius = (hypot(bounds.size.width, bounds.size.height))/2;
    
        UIBezierPath *path = [[UIBezierPath alloc]init];
        for (int radius = maxRadius; radius>0; radius-=20) {
            [path moveToPoint:CGPointMake(center.x+radius, center.y)];
            [path addArcWithCenter:center
                            radius:radius
                        startAngle:0.0
                          endAngle:3.1415926*2
                         clockwise:YES];
            [_circleColor setStroke];
            path.lineWidth = 10;
            [path stroke];
        }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat red = arc4random()%100/100.0;
    CGFloat green = arc4random()%100/100.0;
    CGFloat blue = arc4random()%100/100.0;
    UIColor *randomColor = [[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}
@end
