//
//  XZTimetableModel.h
//  TimetableDB
//
//  Created by zxz on 15/12/12.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZTimetableModel : NSObject
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *courseName;
@property (nonatomic,copy) NSString *teacherName;
@property (nonatomic,copy) NSString *classroom;
@property (nonatomic,copy) NSString *schooltime;
@property (nonatomic,copy) NSString *weeks;//1,3,4,
@property (nonatomic,copy) NSString *homework;
@property (nonatomic,copy) NSString *startingAndEndingTime; //星期一第一节共2节:1,1,2,
@property (nonatomic,copy) NSString *examination;
@property (nonatomic,copy) NSString *checkingStandard;
@property (nonatomic,copy) NSString *maxAbsenceNumber;


@end
