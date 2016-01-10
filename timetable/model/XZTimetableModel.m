//
//  XZTimetableModel.m
//  TimetableDB
//
//  Created by zxz on 15/12/12.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZTimetableModel.h"

@implementation XZTimetableModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.ID = [NSNumber new];
        self.courseName = @"";
        self.teacherName = @"";
        self.classroom = @"";
        self.startingAndEndingTime = @"";
        self.schooltime = @"";
        self.weeks = @"";
        self.homework = @"";
        self.examination = @"";
        self.checkingStandard = @"";
        self.maxAbsenceNumber = @"";
    }
    return self;
}
@end
