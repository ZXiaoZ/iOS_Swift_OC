//
//  Person.m
//  Block的学习
//
//  Created by zxz on 15/11/19.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize dog = _dog;

-(void)setDog:(Dog *)dog
{
    if (_dog !=dog) {
        _dog = dog;
        [_dog setBark:^(Dog *thisDog, int count) {
            NSLog(@"person dog %d count %d",thisDog.ID,count);
        }];
    }
}

//- (void)dealloc
//{
//    _dog = nil;
//    [self dealloc];
//}

@end
