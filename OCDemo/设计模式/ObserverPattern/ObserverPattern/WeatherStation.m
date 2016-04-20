//
//  WeatherStation.m
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#import "WeatherStation.h"
#import "Observer.h"

@interface NSObject(ObserverExtention)<Observer>
@end


@implementation WeatherStation

- (instancetype)init {
    self = [super init];
    if (self) {
        _observers = [NSMutableArray new];
    }
    return self;
}
- (void)notify:(id)value {
    if (_observers == nil){
        _observers = [NSMutableArray new];
    }
    for (id obj in _observers) {
        [obj observeValueChange];
    }
    
}

- (void)removeObserver:(NSObject<Observer> *)observer {
    if ([observer conformsToProtocol:@protocol(Observer)])
        [_observers removeObject:observer];
}
- (void)addObserver:(NSObject<Observer> *)observer{
    if ([observer conformsToProtocol:@protocol(Observer)])
    [_observers addObject:observer];
}
- (void)setTemprature:(NSString *)newTemprature{
    _temprature = newTemprature;
    [self notify:_temprature];
}

-(void)dealloc {
    _observers = nil;
}
@end

