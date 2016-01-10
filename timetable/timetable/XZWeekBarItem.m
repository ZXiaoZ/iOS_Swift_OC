//
//  XZWeekBarItem.m
//  dateDemo
//
//  Created by zxz on 15/12/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZWeekBarItem.h"

@implementation XZWeekBarItem
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _weekLabel.backgroundColor = [UIColor clearColor];
        _weekLabel.font = [UIFont boldSystemFontOfSize:[self caclulateFontSize]];
        
        _dateLabel = [[UILabel alloc]init];
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.layer.borderWidth = 2.0;
        self.layer.cornerRadius = frame.size.width/2.0;
    }
    [self addSubview:_weekLabel];
    return self;
}
-(int)caclulateFontSize{
    CGSize maxSize=CGSizeMake(self.frame.size.width*0.75, self.frame.size.height/3);
    int currentFontSize=17;
    NSString *str=@"一";
    CGSize requiredSize = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:currentFontSize]} context:nil].size;
    if(requiredSize.height<=maxSize.height)
    {
        while (requiredSize.height<=maxSize.height&&requiredSize.width<maxSize.width) {
            currentFontSize++;
            requiredSize=[str boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:currentFontSize]} context:nil].size;
        }
    }else
    {
        while (requiredSize.height>maxSize.height||requiredSize.width>maxSize.width) {
            currentFontSize--;
            requiredSize=[str boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:currentFontSize]} context:nil].size;
        }
        requiredSize=[str boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:currentFontSize]} context:nil].size;
    }
    return currentFontSize;

}

@end
