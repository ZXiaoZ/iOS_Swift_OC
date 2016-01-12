//
//  ZXZDrawVC.m
//  UITouch学习
//
//  Created by zxz on 15/11/27.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZDrawVC.h"

@interface ZXZDrawVC ()

@end

@implementation ZXZDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[ZXZDrawView alloc]init];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
