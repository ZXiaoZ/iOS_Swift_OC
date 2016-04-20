//
//  Observable.h
//  ObserverPattern
//
//  Created by zxz on 4/20/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#ifndef Observable_h
#define Observable_h
#import <Foundation/Foundation.h>
#import "Observer.h"

@protocol Observable
@property (nonatomic,strong) NSMutableArray<Observer> *observers;
- (void)notify:(id)value;
- (void)addObserver:(NSObject<Observer> *)observer;
- (void)removeObserver:(NSObject<Observer> *)observer;
@end

#endif /* Observable_h */
