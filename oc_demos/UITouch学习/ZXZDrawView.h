//
//  ZXZDrawView.h
//  UITouch学习
//
//  Created by zxz on 15/11/27.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXZLine.h"

@interface ZXZDrawView : UIView
@property (nonatomic,strong) NSMutableDictionary *multiLines;
@property (nonatomic,strong) NSMutableArray *finishedLines;
@property (nonatomic,weak) ZXZLine *selectedLine;
@property (nonatomic,strong) UIPanGestureRecognizer *moveRecognizer;
@end
