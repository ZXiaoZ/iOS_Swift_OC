//
//  XZClassCellView.h
//  tableDemo
//
//  Created by zxz on 15/12/28.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTimetableModel.h"

@interface XZClassCellView : UIImageView
@property (nonatomic, strong) UILabel *classLabel;
@property (nonatomic, strong) XZTimetableModel *timetable;


@end
