//
//  XZClassPickerVC.m
//  classTimeDemo
//
//  Created by zxz on 15/12/22.
//  Copyright © 2015年 zxz. All rights reserved.
//
#define headAndTailSpace 20.0f
#define textFieldHeight 44.0f
#define textFieldWidth (self.view.frame.size.width-headAndTailSpace*2)
#define SpaceBetweenTextField 10.0f
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "XZClassPickerVC.h"

@interface XZClassPickerVC ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    XZRoundRect *weeksBackView;
    UILabel     *lab;
}
@property (nonatomic, strong) XZTimetableModel *timetable;

@property (nonatomic, strong) XZPickerView *classPicker;
@property (nonatomic, strong) UIView *supPickerView; // 装载pickerView
@property (nonatomic, strong) UIView *pickTool;
@property (nonatomic, strong) UIView *maskView; // 遮罩层

@property (nonatomic, strong) JVFloatLabeledTextField *startingAndEndingTimeTF;
@property (nonatomic, copy)   NSString *startingAndEndingTime;
@property (nonatomic, strong) JVFloatLabeledTextField *courseNameTF;
@property (nonatomic, strong) JVFloatLabeledTextField *classRoomTF;
@property (nonatomic, strong) JVFloatLabeledTextField *teacherNameTF;
@property (nonatomic, strong) UILabel                 *weeksLabel;
@property (nonatomic, strong) JVFloatLabeledTextField *weeksLabelTF;

@property (nonatomic, strong) NSArray  *slectClassNumber;
@property (nonatomic, strong) NSArray  *week;
@property (nonatomic, strong) NSMutableArray *numberOfClasser;
@property (nonatomic, strong) NSArray  *arr;


@end

@implementation XZClassPickerVC
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.timetable = [[XZTimetableModel alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(204,204,204);
    [self registerForKeyboardNotifications];
    [self loadTextUI];
    _startingAndEndingTimeTF.delegate = self;
    _courseNameTF           .delegate = self;
    _classRoomTF            .delegate = self;
    _teacherNameTF          .delegate = self;
    
    
    _slectClassNumber = [NSArray arrayWithObjects:@"第1节",@"第2节",@"第3节",@"第4节",@"第5节",@"第6节",@"第7节",@"第8节",@"第9节",@"第10节",@"第11节",@"第12节", nil];
    _week = [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    _numberOfClasser =[NSMutableArray arrayWithObjects:@"共1节",@"共2节",@"共3节",@"共4节",@"共5节",@"共6节",@"共7节",@"共8节",@"共9节",@"共10节",@"共11节",@"共12节", nil];
    _arr  = [NSArray arrayWithObjects:_week,_slectClassNumber,_numberOfClasser, nil];

    [self loadData];
}


- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    if (![self.courseNameTF.text isEqualToString:@""] &&
        ![self.startingAndEndingTimeTF.text isEqualToString:@""]) {
        self.timetable.startingAndEndingTime = self.startingAndEndingTime;
        self.timetable.courseName            = self.courseNameTF.text;
        self.timetable.classroom             = self.classRoomTF.text;
        self.timetable.weeks                 = self.weeksLabel.text;
        self.timetable.teacherName           = self.teacherNameTF.text;
        if (self.timetable.ID != NULL) {
            [[XZTimetableService sharedTimetableService] updateTimetable:self.timetable];
        }else{
        [[XZTimetableService sharedTimetableService] insertTimetable:self.timetable];
        }
    }
    
}

-(void)loadData{
    if (![self.timetable.courseName isEqualToString:@""] &&
        ![self.timetable.startingAndEndingTime isEqualToString:@""]) {
        _courseNameTF.text            = self.timetable.courseName;
        _classRoomTF.text             = self.timetable.classroom;
        _teacherNameTF.text           = self.timetable.teacherName;
        _startingAndEndingTimeTF.text = self.timetable.startingAndEndingTime;
        _weeksLabel.text              = self.timetable.weeks;
    }
}
- (void)loadTextUI{
    CGFloat topOffset = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
    _courseNameTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(headAndTailSpace, topOffset+headAndTailSpace, textFieldWidth, textFieldHeight)];
    _courseNameTF.placeholder = @"课程名";
    _courseNameTF.font = [UIFont systemFontOfSize:16.0f];
    _courseNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    _courseNameTF.floatingLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    _courseNameTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_courseNameTF];
    
    //教室
    _classRoomTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(headAndTailSpace, _courseNameTF.frame.origin.y + textFieldHeight + SpaceBetweenTextField, textFieldWidth/2.0-10.0, textFieldHeight)];
    _classRoomTF.placeholder = @"教室:";
    _classRoomTF.font = [UIFont systemFontOfSize:16.0f];
    _classRoomTF.borderStyle = UITextBorderStyleRoundedRect;
    
    _classRoomTF.floatingLabel.font = [UIFont boldSystemFontOfSize:11.0];
    _classRoomTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_classRoomTF];
    
    //老师
    _teacherNameTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(headAndTailSpace + textFieldWidth/2.0+10.0, _courseNameTF.frame.origin.y + textFieldHeight + SpaceBetweenTextField, textFieldWidth/2.0-10.0, textFieldHeight)];
    _teacherNameTF.placeholder = @"老师:";
    _teacherNameTF.font = [UIFont systemFontOfSize:16.0f];
    _teacherNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    _teacherNameTF.floatingLabel.font = [UIFont boldSystemFontOfSize:11.0];
    _teacherNameTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_teacherNameTF];
    
    //上课时间
    _startingAndEndingTimeTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(headAndTailSpace, _classRoomTF.frame.origin.y+SpaceBetweenTextField+textFieldHeight, textFieldWidth, textFieldHeight)];
    _startingAndEndingTimeTF.placeholder = @"上课时间:";
    _startingAndEndingTimeTF.font = [UIFont systemFontOfSize:16.0f];
    _startingAndEndingTimeTF.borderStyle = UITextBorderStyleRoundedRect;
    
    _startingAndEndingTimeTF.floatingLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    _startingAndEndingTimeTF.backgroundColor = [UIColor whiteColor];
    UIButton *_startingAndEndingTimeView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, textFieldWidth, textFieldHeight)];
    _startingAndEndingTimeView.backgroundColor = [UIColor clearColor];
    [_startingAndEndingTimeView addTarget:self action:@selector(chooseClassTime) forControlEvents:UIControlEventTouchUpInside];
    [_startingAndEndingTimeTF addSubview:_startingAndEndingTimeView];
    [self.view addSubview:_startingAndEndingTimeTF];
    
    //上课周
    lab = [[UILabel alloc]initWithFrame:CGRectMake(headAndTailSpace, _startingAndEndingTimeTF.frame.origin.y+SpaceBetweenTextField+textFieldHeight, textFieldWidth, textFieldHeight)];
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.textColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"上课周";
    [self.view addSubview:lab];
    weeksBackView = [[XZRoundRect alloc]init];
    weeksBackView.backgroundColor = [UIColor lightGrayColor];
    _weeksLabel = [[UILabel alloc]init];
#warning NeedDataBaseDATA 从数据库来的数据
    [self getFrameOfWeeksLabel:@""];
    _weeksLabel.numberOfLines = 0;
    _weeksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _weeksLabel.textAlignment = NSTextAlignmentCenter;
    _weeksLabel.backgroundColor = [UIColor lightGrayColor];
    _weeksLabel.userInteractionEnabled = YES;
    [_weeksLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self    action:@selector(tapWeekLabel:)]];
    [weeksBackView addSubview:_weeksLabel];
    [self.view addSubview:weeksBackView];
    
    //上课时间选择
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect main = self.view.frame;
    //pickToolView
    _pickTool = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width/8.0)];
    _pickTool.backgroundColor = RGBColor(204,204,204);
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, 0, width/8.0*2.0, width/8.0);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_pickTool addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(width-width/8.0*2.0, 0, width/8.0*2.0, width/8.0);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [_pickTool addSubview:confirmBtn];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(width/8.0*2.0, 0, width-width/8.0*4.0, width/8.0)];
    message.textAlignment = NSTextAlignmentCenter;
    message.text = @"请输入上课时间";
    [_pickTool addSubview:message];
    //_classPickerView
    _classPicker = [[XZPickerView alloc]initWithFrame:CGRectMake(0, main.size.width/8.0, main.size.width, main.size.width/8.0*3.0)];
    _classPicker.backgroundColor = RGBColor(204,204,204);
    _classPicker.dataSource = self;
    _classPicker.delegate = self;
    
    self.supPickerView = [[UIView alloc]initWithFrame:CGRectMake(0, main.size.height-main.size.width/8.0*4.0, main.size.width, main.size.width/8.0*4.0)];
    self.supPickerView.backgroundColor = [UIColor clearColor];
    
    self.maskView = [[UIView alloc] initWithFrame:main];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];

}
-(void)chooseClassTime{

    [self.view endEditing:YES];
    [_supPickerView addSubview:_pickTool];
    [_supPickerView addSubview:_classPicker];
    CGRect frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.width/8.0*4.0);
    _supPickerView.frame = frame;
    [self.view addSubview:_maskView];
    [self.view addSubview:_supPickerView];
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        _supPickerView.frame = CGRectMake(0, self.view.frame.size.height - self.view.frame.size.width/8.0*4.0, self.view.frame.size.width, self.view.frame.size.width/8.0*3.0);
    }];
}

#pragma mark - weekLable方法
-(void)tapWeekLabel:(UIGestureRecognizer *)gr{
    self.weeksLabelTF = [[JVFloatLabeledTextField alloc]init];
    self.weeksLabelTF.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44);
    self.weeksLabelTF.backgroundColor = [UIColor lightGrayColor];
    self.weeksLabelTF.placeholder = @"上课周(例:'1-3.8.'代表1、2、3、8周)";
    self.weeksLabelTF.delegate = self;
    [self.view addSubview:self.weeksLabelTF];
    [self.weeksLabelTF becomeFirstResponder];
}
//获取键盘高度
- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        self.weeksLabelTF.frame = CGRectMake(0, self.view.frame.size.height-keyboardSize.height-44, self.view.frame.size.width, 44);
    }];
    
    
//    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    ///keyboardWasShown = YES;
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
//    NSDictionary *info = [notif userInfo];
//    
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        self.weeksLabelTF.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44);
    }];
//    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    // keyboardWasShown = NO;
    
}

#pragma mark - pickerView方法
- (void) hideMyPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
    CGRect frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.width/8.0*4.0);
    _supPickerView.frame = frame;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.supPickerView removeFromSuperview];
    }];
}

-(void)confirm:(id)sender{
    NSString *classTime = [NSString stringWithFormat:@"%@:%@%@",
                           [_arr[0] objectAtIndex:[self.classPicker selectedRowInComponent:0]],
                           [_arr[1] objectAtIndex:[self.classPicker selectedRowInComponent:1]],
                           [_arr[2] objectAtIndex:[self.classPicker selectedRowInComponent:2]]];
    self.startingAndEndingTimeTF.text = classTime;
    self.startingAndEndingTime = [NSString stringWithFormat:@"%li,%li,%li",[self.classPicker selectedRowInComponent:0]+1,[self.classPicker selectedRowInComponent:1]+1,[self.classPicker selectedRowInComponent:2]+1];
    NSLog(@"startingAndEndingTime %@",_startingAndEndingTime);
    [self hideMyPicker];
}

-(void)cancel:(id)sender{
    [self hideMyPicker];
}
#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [_arr count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[_arr objectAtIndex:component] count];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return pickerView.frame.size.height/3.0;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1) {
        return [[_arr objectAtIndex:1] objectAtIndex:row];
    }
    if (component == 0) {
        return [[_arr objectAtIndex:0] objectAtIndex:row];
    }else{
        return [_numberOfClasser objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"共1节",@"共2节",@"共3节",@"共4节",@"共5节",@"共6节",@"共7节",@"共8节",@"共9节",@"共10节",@"共11节",@"共12节", nil];
    if (component == 1) {
        [_numberOfClasser removeAllObjects];
        for (NSInteger i=0; i<(12-row); i++) {
            [_numberOfClasser addObject:[array objectAtIndex:i]];
        }
        [pickerView reloadComponent:2];
    }
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:_weeksLabelTF] && ![textField.text isEqualToString:@""]) {
        _weeksLabel.text = [self extractWeeksStringFrom:_weeksLabelTF.text];
        [self getFrameOfWeeksLabel:_weeksLabel.text];
        _weeksLabelTF.text = @"";
    }
    [textField resignFirstResponder];
    return YES;
}
//提取输入的所有周
- (NSString *)extractWeeksStringFrom:(NSString *)str{
    NSArray *tem = [str componentsSeparatedByString:@"."];
    NSMutableArray *mArr = [NSMutableArray array];
    XZNumValidator *numValidator = [[XZNumValidator alloc]init];
    for (NSString *obj in tem) {
        NSString *regex = @"^\\d+\\-\\d+$";
        if ([numValidator checkIfValid:obj WithRegex:regex]) {
            NSLog(@"%@",obj);
            NSArray *arr = [obj componentsSeparatedByString:@"-"];
            NSString *bNum = [arr objectAtIndex:0];
            NSString *eNum = [arr objectAtIndex:1];
            if ([bNum integerValue]<[eNum integerValue]) {
                for (NSInteger i=[bNum integerValue]; i<=[eNum integerValue]; i++) {
                    NSString *num = [NSString stringWithFormat:@"%li",i];
                    if (![mArr containsObject:num] && [num integerValue]<57) {
                        [mArr addObject:[NSNumber numberWithInteger:[num integerValue]]];
                    }
                    
                }
            }
        }
    }
    for (NSString *obj in tem) {
        NSString *regex = @"^[1-9][0-9]?$";
        if ([numValidator checkIfValid:obj WithRegex:regex]) {
            NSLog(@"%@",obj);
            if (![mArr containsObject:obj] && [obj integerValue]<57) {
                [mArr addObject:[NSNumber numberWithInteger:[obj integerValue]]];
            }
        }
    }
    
    NSMutableString *weeksStr = [NSMutableString new];
    for (NSNumber *s in [mArr sortedArrayUsingSelector:@selector(compare:)]) {
        [weeksStr appendString:[NSString stringWithFormat:@"%@,",s ]];
    }
    NSLog(@"mArr count %li",[mArr count]);
    NSLog(@"weeksStr %@",weeksStr);
    return [weeksStr copy];
}
- (CGSize)getFrameOfWeeksLabel:(NSString *)weesLabelText{
    NSString *weekText = [NSString stringWithFormat:@"%@",weesLabelText];
    CGSize constraintSize;
    constraintSize.width = 300;
    constraintSize.height = MAXFLOAT;
    CGSize size = [weekText boundingRectWithSize:CGSizeMake(textFieldWidth, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size;
    if (size.height < 60) {
        size.height =60;
    }
    weeksBackView.frame = CGRectMake(headAndTailSpace, lab.frame.origin.y+textFieldHeight, textFieldWidth, size.height+60);
    _weeksLabel.frame = CGRectMake(10, 10, textFieldWidth-20, size.height+40);

    return size;
}


@end
