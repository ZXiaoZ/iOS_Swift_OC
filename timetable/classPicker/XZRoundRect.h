//
//  XZRoundRect.h
//  pickerView
//
//  Created by zxz on 15/12/16.
//  Copyright © 2015年 zxz. All rights reserved.
//
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import <UIKit/UIKit.h>

@interface XZRoundRect : UIView

@property (nonatomic,strong)UILabel *textLable;
@property (nonatomic)BOOL beSelected;
@end
