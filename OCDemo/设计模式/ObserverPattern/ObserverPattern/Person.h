//
//  Person.h
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observer.h"

@interface Person : NSObject<Observer>

@property (nonatomic,copy) NSString *name;
@end
