//
//  BubbleView.h
//  NewProject
//
//  Created by Andy Deng on 15/12/10.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView
@property (nonatomic,copy)NSString *lableText;

- (id)initWithFrame:(CGRect)frame bubbleColor:(UIColor*)color;
@end
