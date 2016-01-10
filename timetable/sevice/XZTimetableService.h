//
//  XZTimetableService.h
//  BubbleChooseClass
//
//  Created by zxz on 15/12/25.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZTimetableModel.h"
#import "XZTimetableDB.h"
#import "NSObject+Help.h"
@interface XZTimetableService : NSObject
+(instancetype)sharedTimetableService;
-(void)insertTimetable:(XZTimetableModel *)timetable;
-(void)deleteTimetable:(XZTimetableModel *)timetable;
-(void)updateTimetable:(XZTimetableModel *)timetable;
-(NSArray *)getAllTimetable;


@end
