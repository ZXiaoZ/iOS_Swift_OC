//
//  XZTimetableService.m
//  BubbleChooseClass
//
//  Created by zxz on 15/12/25.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import "XZTimetableService.h"
static XZTimetableService *_timetableService = nil;

@implementation XZTimetableService
+(instancetype)sharedTimetableService{
    if (!_timetableService) {
        _timetableService = [[self alloc]initPrivate];
    }
    return _timetableService;
}
-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [XZTimetableService sharedTimetableService]" userInfo:nil];
    return nil;

}
-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)insertTimetable:(XZTimetableModel *)timetable{
//    NSDictionary *dic = [[NSDictionary alloc]init];
//    [dic setValue:timetable.courseName  forKey:@"courseName"];
//    [dic setValue:timetable.teacherName forKey:@"teacherName"];
//    [dic setValue:timetable.classroom   forKey:@"classroom"];
//    [dic setValue:timetable.startingTime forKey:@"startingTime"];
//    [dic setValue:timetable.endingTime forKey:@"endingTime"];
//    [dic setValue:timetable.weeks forKey:@"weeks"];
    NSLog(@"[timetable properties_aps] %@",[timetable properties_aps]);
    [[XZTimetableDB sharedDB]insertTimetable:[timetable properties_aps]];
    
}
-(void)deleteTimetable:(XZTimetableModel *)timetable{
    [[XZTimetableDB sharedDB] deleteTimetable:timetable.ID];
}
-(void)updateTimetable:(XZTimetableModel *)timetable{
    NSString *updateSQL = [NSString stringWithFormat:@"update timetable set courseName='%@',teacherName='%@',classroom='%@',schooltime='%@',weeks='%@',startingAndEndingTime='%@' where id = %i",timetable.courseName,timetable.teacherName,timetable.classroom,timetable.schooltime,timetable.weeks,timetable.startingAndEndingTime,[timetable.ID intValue]];
    [[XZTimetableDB sharedDB] updateTable:updateSQL];
}
-(NSArray *)getAllTimetable{
    NSArray *arr = [[XZTimetableDB sharedDB] timetables];
    NSMutableArray *mArr = [NSMutableArray new];
    for (NSDictionary *obj in arr) {
        XZTimetableModel *timetable = [[XZTimetableModel alloc]init];
        [timetable setValuesForKeysWithDictionary:obj];
//        timetable.ID = [obj valueForKey:@"ID"];
//        timetable.courseName = [obj valueForKey:@"courseName"];
//        timetable.teacherName = [obj valueForKey:@"teacherName"];
//        timetable.classroom = [obj valueForKey:@"classroom"];
//        timetable.startingTime = [obj valueForKey:@"startingTime"];
//        timetable.endingTime = [obj valueForKey:@"endingTime"];
//        timetable.weeks = [obj valueForKey:@"weeks"];
        [mArr addObject:timetable];
    }
    return mArr;
}
@end
