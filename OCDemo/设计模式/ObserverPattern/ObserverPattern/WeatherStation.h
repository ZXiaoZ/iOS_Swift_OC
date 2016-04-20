//
//  WeatherStation.h
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observable.h"

@interface WeatherStation : NSObject <Observable>
@property (nonatomic,copy) NSString *temprature;
@property (nonatomic,strong) NSMutableArray<Observer> *observers;

@end
