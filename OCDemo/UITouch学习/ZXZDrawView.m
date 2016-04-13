//
//  ZXZDrawView.m
//  UITouch学习
//
//  Created by zxz on 15/11/27.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZDrawView.h"

@interface ZXZDrawView() <UIGestureRecognizerDelegate>


@end
@implementation ZXZDrawView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _finishedLines = [[NSMutableArray alloc]init];
        _multiLines = [[NSMutableDictionary alloc]init];
        self.multipleTouchEnabled = YES;
        
        //点击两次
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delaysTouchesBegan= YES;//延迟实现touchBegin
        [self addGestureRecognizer:doubleTap];
        
        //单击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.delaysTouchesBegan = YES;
        tap.numberOfTapsRequired = 1;
        [tap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:tap];
        
        //长按longPress
        UILongPressGestureRecognizer *PressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:PressGesture];
        //拖动手势,移动线条
        self.moveRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:_moveRecognizer];

        
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor]setStroke];
    for (ZXZLine *line in self.finishedLines) {
        [self strokeLine:line];
//        [self stokeCircle:line];
        
    }
    [[UIColor redColor]setStroke];
    for (NSValue *key in self.multiLines) {
        [self strokeLine:self.multiLines[key]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] setStroke];
        [self strokeLine:_selectedLine];
    }
}
//移动线条
-(void)moveLine:(UIPanGestureRecognizer *) gr
{
    if (!self.selectedLine) {
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translationP = [gr translationInView:self];
        
        //将移动距离加至选中线条的起点和终点
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translationP.x;
        begin.y += translationP.y;
        end.x += translationP.x;
        end.y += translationP.y;
        
        //设置新的起点和终点
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        
        //使当前选中的线的位置和手指位置保持一致
        [gr setTranslation:CGPointZero inView:self];
    }
}

//longPress方法
-(void)longPress:(UIGestureRecognizer *)gr
{
    NSLog(@"______________");
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAroundPoint:point];
        
        if (self.selectedLine) {
            [self.multiLines removeAllObjects];
        }
    }else if (gr.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

//双点删除全部线
-(void)doubleTap
{
    [self.finishedLines removeAllObjects];
    [self.multiLines removeAllObjects];
    [self setNeedsDisplay];
}


//tap手势方法
-(void)tap:(UIGestureRecognizer *)gr{
    CGPoint point = [gr locationInView:self];
//    self.selectedLine = [self lineAtPoint:point];
    self.selectedLine = [self lineAroundPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        //delete
        UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        //UIMenuController显示区域,设置为可见
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }else{
        //如果没有选中线,隐藏UIMenuContoller
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

-(void)deleteLine:(id)sender
{
    //删除线
    [self.finishedLines removeObject:self.selectedLine];
    
    [self setNeedsDisplay];
}

//设置UIView为第一响应对象
-(BOOL)canBecomeFirstResponder
{
    return YES;
}


//求线段的中点
-(CGPoint)center:(ZXZLine *)l
{
    CGPoint center ;
    center.x = (l.begin.x +l.end.x)/2;
    center.y = (l.begin.y + l.end.y)/2;
    return center;
}

//求线段的长度
-(double)lengthAlongPoint:(CGPoint)p1 withPoint:(CGPoint)p2
{
    double len = fabs(p1.x-p2.x)*fabs(p1.x-p2.x) +fabs(p1.y-p2.y)*fabs(p1.y-p2.y);
    return sqrt(len);
}

//自定义取点方法
-(ZXZLine *)lineAroundPoint:(CGPoint) p
{
    for (ZXZLine *l in _finishedLines) {
        double a = [self lengthAlongPoint:l.begin withPoint:l.end];
        double b = [self lengthAlongPoint:l.begin withPoint:p];
        double c = [self lengthAlongPoint:l.end withPoint:p];
        double length = b+c-a;
        if (length <5) {
            return l;
        }
    }
    return nil;
}

//取点方法
-(ZXZLine *)lineAtPoint:(CGPoint) p
{
    for (ZXZLine *l in _finishedLines)
    {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        for (float t = 0.0; t <=1.0; t+=0.05) {
            float x = start.x + t*(end.x - start.x);
            float y = start.y + t*(end.y - start.y);
            
            if (hypot(x-p.x, y-p.x) <20) {
                return l;
            }
        }
    }
    return nil;
}

//绘制线的方法
-(void)strokeLine:(ZXZLine *)line{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
}
//touch方法取点
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        ZXZLine *line = [[ZXZLine alloc]init];
        line.begin = location;
        line.end = location;
        self.multiLines [key] = line;

    }
    [self setNeedsDisplay];

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        ZXZLine *line = self.multiLines [key];
        line.end = location;
    }
    [self setNeedsDisplay];

}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        ZXZLine *line = self.multiLines [key];
     
        
        [self.finishedLines addObject:line];
        [self.multiLines removeObjectForKey:key];
        
    }
    [self setNeedsDisplay];

}
@end
