//
//  PaperInfoManager.h
//  JsonCoreData
//
//  Created by zxz on 16/1/6.
//  Copyright © 2016年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaperInfoManager : NSObject
+(void)insertIntoPaperInfo:(NSDictionary *)dataArr;
+(NSArray *)findAllPapers;
+(void)insertAllPapers:(NSArray *)dataArr;
@end
