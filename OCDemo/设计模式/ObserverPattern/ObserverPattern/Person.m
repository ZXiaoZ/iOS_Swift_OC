//
//  Person.m
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)observeValueChange{
    NSLog(@"%@ observe Value Change",_name);
}
@end
