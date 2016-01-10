//
//  ZXZUIView.m
//  UIView学习
//
//  Created by zxz on 15/11/11.
//  Copyright © 2015年 zxz. All rights reserved.
//
#import "ZXZUIView.h"

@implementation ZXZUIView

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    CGRect bounds = rect;
//    CGPoint center;
//    center.x = bounds.size.width/2;
//    center.y = bounds.size.height/2;
////    float radius = MIN(bounds.size.width, bounds.size.height)/2;
//    float maxRadius = (hypot(bounds.size.width, bounds.size.height))/2;
//    
//    UIBezierPath *path = [[UIBezierPath alloc]init];
//    for (int radius = maxRadius; radius>0; radius-=20) {
//        [path moveToPoint:CGPointMake(center.x+radius, center.y)];
//        [path addArcWithCenter:center
//                        radius:radius
//                    startAngle:0.0
//                      endAngle:3.1415926*2
//                     clockwise:YES];
//        [[UIColor greenColor] setStroke];
//        path.lineWidth = 10;
//        [path stroke];
//    }
    
    
    //Core Graphics
    //创建CGContexRef
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    //设置圆心和半径以及画笔颜色,线条宽度
    CGPoint center;
    center.x = rect.size.width/2;
    center.y = rect.size.height/2;
    CGFloat radius = hypot(rect.size.width, rect.size.height)/2;
    CGContextSetRGBStrokeColor(currentContext,0,1,0,1);
    CGContextSetLineWidth(currentContext, 10.0);
    //循环体
    for (CGFloat currentRadius = radius; currentRadius > 0; currentRadius-=20) {
        //创建path
        CGMutablePathRef path = CGPathCreateMutable();
        //绘制函数
        CGPathAddArc(path, NULL, center.x, center.y, currentRadius, 0.0, M_PI*2, YES);
        //将path加入当前环境
        CGContextAddPath(currentContext, path);
        //绘制path
        CGContextStrokePath(currentContext);
        //释放path
        CGPathRelease(path);
    }
    
    //绘制渐变
    CGContextSaveGState(currentContext);
    //创建裁剪路径
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, center.x, center.y-rect.size.height/4);
    CGPathAddLineToPoint(path2, NULL, center.x+rect.size.width/4, center.y+rect.size.height/4+30);
    CGPathAddLineToPoint(path2, NULL, center.x-rect.size.width/4, center.y+rect.size.height/4+30);
    CGPathCloseSubpath(path2);
    CGContextAddPath(currentContext, path2);

    CGContextClip(currentContext);

    
    //渐变点/色域
    CGFloat locations[2] = {0.0,1.0};
    CGFloat components[8] = {1.0,0.0,0.0,1.0,
                             1.0,1.0,0.0,1.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGPoint startPoint = CGPointMake(center.x, center.y-rect.size.height/4);
    CGPoint endPoint = CGPointMake(center.x, center.y+rect.size.height/4);
    //线向渐变
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    CGContextRestoreGState(currentContext);
    
    //绘制阴影效果
    CGContextSaveGState(currentContext);//保存当前绘制状态
    //向下/向右偏移,blur虚化程度
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:CGRectMake(center.x-rect.size.width/4, center.y-rect.size.height/4, rect.size.width/2, rect.size.height/2)];
    CGContextRestoreGState(currentContext);//恢复以前绘制状态

}


@end
