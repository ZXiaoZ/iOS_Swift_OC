//
//  main.m
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "WeatherStation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        WeatherStation *station1 = [WeatherStation new];

        
        Person *p1 = [Person new];
        p1.name = @"Jim";
        Person *p2 = [Person new];
        p2.name = @"Tom";
        [station1 addObserver:p1];
        [station1 addObserver:p2];

        
        station1.temprature = @"15℃";
        
        [station1 removeObserver:p1];
        station1.temprature = @"new";
        
        
    }
    return 0;
}
