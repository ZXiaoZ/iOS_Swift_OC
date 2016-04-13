//
//  AppDelegate.m
//  动态类型的判定
//
//  Created by zxz on 15/11/5.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "AppDelegate.h"
#import "Square.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    Square *mySquare = [[Square alloc]init];
    
    //isMemberOfClass
    if ([mySquare isMemberOfClass:[Square class]]==YES) {
        NSLog(@"mySquare is member of Square class");
    }
    
    if ([mySquare isMemberOfClass:[Rectangle class]]==YES) {
        NSLog(@"mySquare is member of Rectangle class");
    }
    
    if ([mySquare isMemberOfClass:[NSObject class]]==YES) {
        NSLog(@"mySquare is member of NSObject class");
    }
    
    //isKindOfClass
    if ([mySquare isKindOfClass:[Square class] ]==YES) {
        NSLog(@"mySquare is kind of Square class");
    }
    
    if ([mySquare isKindOfClass:[Rectangle class] ]==YES) {
        NSLog(@"mySquare is kind of Rectangle class");
    }
    
    if ([mySquare isKindOfClass:[NSObject class] ]==YES) {
        NSLog(@"mySquare is kind of NSObject class");
    }
    
    
    //RespondsTo
    if ([mySquare respondsToSelector:@selector(setSide:)]==YES) {
        NSLog(@"mySquare responds to setSide: method");
    }
    
    if ([mySquare respondsToSelector:@selector(setWidth:andHeight:)]==YES) {
        NSLog(@"mySquare responds to setWidth:andHeight: method");
    }
    
    if ([Square  respondsToSelector:@selector(alloc)]==YES) {
        NSLog(@"Square class responds to alloc method");
    }
    
    //instancesRespondsTo
    if ([Rectangle instancesRespondToSelector:@selector(setSide:)] ==YES) {
        NSLog(@"intances of Rectangle responds to setSide: method");
    }
    
    if ([Square instancesRespondToSelector:@selector(setSide:)] ==YES) {
        NSLog(@"intances of Square responds to setSide: method");
    }
        
    if ([[Square class] isSubclassOfClass:[Rectangle class]]==YES) {
        NSLog(@"Square is a subclass of a rectangle");
    }
   
    if ([mySquare respondsToSelector:@selector(print:)]) {
        id obj;
        obj=[mySquare performSelector:@selector(print:)withObject:obj];
        NSLog(@"%@",obj);
        
        [mySquare performSelector:@selector(print:) withObject:obj afterDelay: 10];
    }
    else NSLog(@"No respnds");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
