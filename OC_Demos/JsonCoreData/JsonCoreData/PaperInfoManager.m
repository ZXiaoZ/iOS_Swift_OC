//
//  PaperInfoManager.m
//  JsonCoreData
//
//  Created by zxz on 16/1/6.
//  Copyright © 2016年 zxz. All rights reserved.
//

#import "PaperInfoManager.h"
#import "PaperInfo.h"
#import "AppDelegate.h"
@implementation PaperInfoManager
+(void)insertIntoPaperInfo:(NSDictionary *)dataDic{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;

    PaperInfo *paperInfo = [NSEntityDescription insertNewObjectForEntityForName:@"PaperInfo" inManagedObjectContext:context];
    paperInfo.title = [dataDic valueForKey:@"titile"];
    paperInfo.paperID = [dataDic valueForKey:@"paperID"];
    paperInfo.paperType = [dataDic valueForKey:@"paperType"];
    [appDelegate saveContext];
}
+(void)insertAllPapers:(NSArray *)dataArr{
    for (NSDictionary *dic in dataArr) {
        [self insertIntoPaperInfo:dic];
        
    }
}
+(NSArray *)findAllPapers{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"PaperInfo"];
    NSArray *papers = [context executeFetchRequest:request error:nil];
    return papers;
}
@end
