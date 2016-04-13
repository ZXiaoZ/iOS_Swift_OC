//
//  RootTabViewController.m
//  UITabBarCV滑动切换
//
//  Created by zxz on 15/11/29.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "RootTabViewController.h"

@interface RootTabViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIPanGestureRecognizer *selectedPanGesture;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeGestureLeft;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeGestureRight;

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AViewController *aVC = [[AViewController alloc]init];
    BViewController *bVC = [[BViewController alloc]init];
    CViewController *cVC = [[CViewController alloc]init];
    self.viewControllers = @[aVC,bVC,cVC];
    self.view.backgroundColor = [UIColor redColor];

    self.swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(selectViewController:)];
    self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_swipeGestureLeft];
    self.swipeGestureRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(selectViewController:)];
    self.swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipeGestureRight];
    
}

-(void)selectViewController:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"--------------------");
    static NSInteger num ;
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (num > 2) {
            self.selectedViewController = self.viewControllers[2];
        }else if(num >=0 && num <2){
            self.selectedViewController = self.viewControllers[num+=1];
        }
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        if (num < 0) {
            self.selectedViewController = self.viewControllers[0];
        }else if(num >0 && num <=2 ){
            self.selectedViewController = self.viewControllers[num-=1];
        }
    }

}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@">>>>>");
        
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"<<<<<");
        
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
