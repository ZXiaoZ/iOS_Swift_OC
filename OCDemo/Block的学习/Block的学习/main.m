//
//  main.m
//  Block的学习
//
//  Created by zxz on 15/11/19.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Person *xiaoLi = [[Person alloc]init];
        Dog *dog = [[Dog alloc]init];
        [dog setID:10];
        xiaoLi.dog = dog;
        
        //使定时器转起来
        while (1) {
            [[NSRunLoop currentRunLoop] run];
        }
        
    }
    return 0;
}
