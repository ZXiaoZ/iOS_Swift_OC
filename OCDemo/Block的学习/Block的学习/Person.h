//
//  Person.h
//  Block的学习
//
//  Created by zxz on 15/11/19.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject
{
    Dog *_dog;
}

@property (nonatomic,retain)Dog* dog;
@end
