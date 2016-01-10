//
//  KLMenuViewController.m
//  PopMenuItem
//
//  Created by 康梁 on 15/12/14.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLMenuViewController.h"
#import "JKPopMenuView.h"

@interface KLMenuViewController () <JKPopMenuViewSelectDelegate>



@end

@implementation KLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)popMenuViewSelectIndex:(NSInteger)index {
    NSLog(@"%s", __func__);
    NSLog(@"%ld", index);
}

// 签到
- (void)slectSignView {
    NSLog(@"select sign view");
}

// 缺席
- (void)selectAbsentView {
    NSLog(@"select absent view");
}

// 笔记
- (void)selectNoteView {
    NSLog(@"select note view");
}

// 复习
- (void)selectReviseView {
    NSLog(@"select Recise view");
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
