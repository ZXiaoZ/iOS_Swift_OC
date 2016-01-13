//
//  XZTimetableVC.m
//  tableDemo
//
//  Created by zxz on 15/12/26.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZTimetableVC.h"

@interface XZTimetableVC ()<XZTimetableViewDataSourse,XZTimetableViewDelegate,JKPopMenuViewSelectDelegate>
{
    UIVisualEffectView *visualView;
}
@property (nonatomic ,strong) XZTimetableView *timetableView;
@property (nonatomic ,strong) XZWeekBar *weekBar;
@property (nonatomic ,strong) NSArray *allTimetable;
@end

@implementation XZTimetableVC
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.allTimetable = [[NSArray alloc]init];
        self.allTimetable = [[XZTimetableService sharedTimetableService] getAllTimetable];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:visualView];
    //add toolBar
    [self addTopAndBottomBar];
    
    //main contentView
    self.weekBar = [[XZWeekBar alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.width/5.0)];
//    self.weekBar.backgroundColor = topbar.barTintColor;
    [visualView.contentView addSubview:self.weekBar];
    
    self.timetableView = [[XZTimetableView alloc]init];
    self.timetableView.frame = CGRectMake(0, 44.0+self.view.frame.size.width/5.0, self.view.frame.size.width, self.view.frame.size.height - (44.0*2.0+self.view.frame.size.width/5.0));
    [visualView.contentView addSubview:self.timetableView];
    self.timetableView.delegate = self;
    self.timetableView.dataSourse = self;
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.allTimetable = [[XZTimetableService sharedTimetableService] getAllTimetable];
    NSLog(@"allTimetable  %@",self.allTimetable);
}

-(NSInteger)numberOfRowsInTimetableView:(XZTimetableView *)timetableView{
    return 12;
}
-(NSInteger)numberOfColumnsInTimetableView:(XZTimetableView *)timetableView{
    return 7;
}

-(XZCell *)timetableView:(XZTimetableView *)timetableView cellInPositon:(XZPosition)position{
    CGFloat cellWidth = timetableView.frame.size.width/(7);
    CGFloat cellHeight = timetableView.frame.size.height/(8);
    XZCell *cell = [[XZCell alloc]init];
    for (id obj in self.allTimetable) {
        XZClassCellView *cellView = [[XZClassCellView alloc]init];
        cellView.timetable = (XZTimetableModel *)obj;
        NSLog(@"%@",obj);
        NSArray *arr = [self startAndEndTimeHandler:cellView.timetable.startingAndEndingTime];
        NSInteger week  = [[arr objectAtIndex:0] integerValue];
        NSInteger start = [[arr objectAtIndex:1] integerValue];
        NSInteger total   = [[arr objectAtIndex:2] integerValue];
        if (position.column == week && position.row ==start) {
            cellView.backgroundColor = [self randomColor];
            cellView.frame = CGRectMake(0, 0, cellWidth, cellHeight*(total));
            cellView.classLabel.frame = cellView.frame;
            cellView.classLabel.numberOfLines = 0;
            cellView.classLabel.text = [NSString stringWithFormat:@"%@\n%@",cellView.timetable.courseName,cellView.timetable.classroom];
            [cell addSubview:cellView];
        }
    }
    return cell;
}
-(UIColor *)randomColor{
    CGFloat color = (arc4random() %256 /255.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *randomColor = [UIColor colorWithHue:color saturation:saturation brightness:brightness alpha:0.8];
    return randomColor;
}
-(NSArray *)startAndEndTimeHandler:(NSString *)startAndEndTime{
    NSLog(@"startAndEndTime %@",startAndEndTime);
    NSArray *arr = [startAndEndTime componentsSeparatedByString:@","];
    return arr;
}

#pragma -mark timetable delegate
- (void)timetableView:(XZTimetableView *)timetableView didSelectCellInPosition:(XZPosition)position{
    NSLog(@"%li,%li",position.row,position.column);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // 签到
    JKPopMenuItem *itemSign = [JKPopMenuItem itemWithTitle:@"签到" image:[UIImage imageNamed:@"icon1"]];
    [array addObject:itemSign];
    [itemSign addTarget:self action:@selector(slectSignView) forControlEvents:UIControlEventTouchUpInside];
    
    // 缺席
    JKPopMenuItem *itemAbsent = [JKPopMenuItem itemWithTitle:@"缺席" image:[UIImage imageNamed:@"icon2"]];
    [array addObject:itemAbsent];
    [itemAbsent addTarget:self action:@selector(selectAbsentView) forControlEvents:UIControlEventTouchUpInside];
    
    // 笔记
    JKPopMenuItem *itemNote = [JKPopMenuItem itemWithTitle:@"笔记" image:[UIImage imageNamed:@"icon3"]];
    [array addObject:itemNote];
    [itemNote addTarget:self action:@selector(selectNoteView) forControlEvents:UIControlEventTouchUpInside];
    
    // 复习
    JKPopMenuItem *itemRevise = [JKPopMenuItem itemWithTitle:@"复习" image:[UIImage imageNamed:@"icon4"]];
    [array addObject:itemRevise];
    [itemRevise addTarget:self action:@selector(selectReviseView) forControlEvents:UIControlEventTouchUpInside];
    
    JKPopMenuView *popView = [JKPopMenuView menuViewWithItems:array];
    popView.delegate = self;
    // [self.view addSubview:popView];
    [popView show];
    
}
#pragma - mark jkpop delegate
-(void)popMenuViewSelectIndex:(NSInteger)index{
    
}

// 签到
- (void)slectSignView {
    NSLog(@"select sign view");
}

// 缺席
- (void)selectAbsentView {
    NSLog(@"select absent view");
    KLAbsentViewController *klAbsent = [[KLAbsentViewController alloc]init];
    [self presentViewController:klAbsent animated:YES completion:nil];
}

// 笔记
- (void)selectNoteView {
    NSLog(@"select note view");
}

// 复习
- (void)selectReviseView {
    NSLog(@"select Recise view");
}

#pragma -mark topBar and bottomBar
- (void)addTopAndBottomBar {
    UIToolbar *topbar = [[UIToolbar alloc]init];
    topbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    topbar.barTintColor = [UIColor colorWithRed:247.0/255.0 green:237/255.0 blue:237/255.0 alpha:0.9];
    [visualView.contentView addSubview:topbar];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    topbar.items = @[backButton];
    
    UIToolbar *bottomBar = [[UIToolbar alloc]init];
    bottomBar.frame = CGRectMake(0, self.view.frame.size.height - 44.0, self.view.frame.size.width, 44.0);
    bottomBar.backgroundColor = [UIColor colorWithHue:360 saturation:21 brightness:24 alpha:1.0];
    [visualView.contentView addSubview:bottomBar];
    UIBarButtonItem *backToCurrentWeekButton = [[UIBarButtonItem alloc]initWithTitle:@"本周" style:UIBarButtonItemStylePlain target:self action:@selector(backToCurrentWeekAction:)];
    UIBarButtonItem *nextWeekButton = [[UIBarButtonItem alloc]initWithTitle:@"下周" style:UIBarButtonItemStylePlain target:self action:@selector(nextWeekAction:)];
    UIBarButtonItem *remindButton = [[UIBarButtonItem alloc]initWithTitle:@"提醒" style:UIBarButtonItemStylePlain target:self action:@selector(remindAction:)];
    
    UIBarButtonItem *flexibleButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    bottomBar.items = @[backToCurrentWeekButton,flexibleButton,remindButton,flexibleButton,nextWeekButton];
}
- (void)backButtonAction:(id )sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#warning need to be completed
-(void)backToCurrentWeekAction:(id)sender {
    NSLog(@"backToCurrentWeek ");
}
-(void)nextWeekAction:(id)sender {
    NSLog(@"nextWeekAction ");
}
-(void)remindAction:(id)sender {
    NSLog(@"remindAction ");

}

@end
