//
//  XZClassCellView.m
//  tableDemo
//
//  Created by zxz on 15/12/28.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZClassCellView.h"

@implementation XZClassCellView

-(instancetype)init{
    self = [super init];
    if (self) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_classLabel];
    }
    return self;
}


@end
