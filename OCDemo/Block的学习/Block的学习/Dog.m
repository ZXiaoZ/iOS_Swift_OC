//
//  Dog.m
//  Block的学习
//
//  Created by zxz on 15/11/19.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "Dog.h"

@implementation Dog
@synthesize ID = _ID;


-(instancetype)init
{
    self = [super init];
    if (self) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void) setBark:(void (^) (Dog* thisDog,int count))eachBark
{
    BarkCallBack = eachBark ;
}

-(void)updateTimer:(id)arg
{
    barkCount++;
    NSLog(@"dog %d bark count %d",_ID,barkCount);
    if (BarkCallBack) {
        BarkCallBack(self,barkCount);
        //调用从person传过来的Blocks
    }
}
@end
