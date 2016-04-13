//
//  Dog.h
//  Block的学习
//
//  Created by zxz on 15/11/19.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
{
    int _ID;
    NSTimer *timer;
    int barkCount;
    //定义一个Block'变量
    void (^BarkCallBack) (Dog* thisDog,int count);
}
@property int ID;
-(void) setBark:(void (^) (Dog* thisDog,int count))eachBark;
-(void)updateTimer:(id)arg;

@end
