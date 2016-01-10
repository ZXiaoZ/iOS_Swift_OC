//
//  XZWeekBar.m
//  dateDemo
//
//  Created by zxz on 15/12/9.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZWeekBar.h"

@interface XZWeekBar()
{
    NSMutableArray *tem;
}
@end
@implementation XZWeekBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        tem = [[NSMutableArray alloc]init];
        _weekItem = [[NSArray alloc]init];
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        [self drawDaysView];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

//绘制星期栏
-(void)drawDaysView{
    //获取当前周
    NSArray *arr = [self getWeekArray];
    NSLog(@"%@",arr);
    for (NSInteger i=1; i<=7; i++) {
        XZWeekBarItem *btn = [[XZWeekBarItem alloc]initWithFrame:CGRectMake(self.frame.size.width/7*(i-1), 0, self.frame.size.width/7.0, self.frame.size.width/7.0)];
        
        NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
//        dateFromatter.dateFormat = @"yyyy/MM/dd' 'HH:mm' 'cccc";
        dateFromatter.dateFormat = @"MM/dd";
        
        NSDateFormatter *weekFomatter = [[NSDateFormatter alloc]init];
        weekFomatter.dateFormat = @"ccc";
        btn.dateLabel.text = [dateFromatter stringFromDate:[arr objectAtIndex:i-1]];
        btn.weekLabel.text = [weekFomatter stringFromDate:[arr objectAtIndex:i-1]];
        btn.dateLabel.textAlignment = NSTextAlignmentCenter;
        btn.weekLabel.textAlignment  = NSTextAlignmentCenter;
        btn.tag = i;
        [self addSubview:btn];
        btn.dateLabel.frame = CGRectMake(self.frame.size.width/7*(i-1), btn.weekLabel.frame.size.height, btn.frame.size.width, self.frame.size.height - btn.frame.size.width);
        btn.dateLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:btn.dateLabel];
        [tem addObject:btn];
    }
    _weekItem = [NSArray arrayWithArray:tem];
}

//获得当前周
-(NSArray *)getWeekArray{
    XZCurrentWeek *currentWeek = [[XZCurrentWeek alloc]init];
    _weekArray = [currentWeek currentWeek:[NSDate date]];
    return _weekArray;
}
@end
