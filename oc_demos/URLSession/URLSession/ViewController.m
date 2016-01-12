//
//  ViewController.m
//  URLSession
//
//  Created by zxz on 16/1/6.
//  Copyright © 2016年 zxz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *arr;
}
@end

@implementation ViewController

-(void)addTableViewConstrains{
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *tableViewMap = @{@"tableView":_tableView};
    NSArray *constrainsHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[tableView]-5-|" options:0 metrics:nil views:tableViewMap];
    [self.view addConstraints:constrainsHorizontal];
    NSArray *constrainsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[tableView]-0-|" options:0 metrics:nil views:tableViewMap];
    [self.view addConstraints:constrainsVertical];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"1,2,3,4";
    [str componentsSeparatedByString:@","];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://112.124.122.38/acountingExam/getPaperInfo.php"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:0];
        NSLog(@"%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            arr = [NSArray arrayWithArray:json];
            [_tableView reloadData];
 
        });
    }];
    [task resume];
    [self addTableViewConstrains];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - tableViewDatasourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = arr[indexPath.row];
    NSString *titile = [dic objectForKey:@"title"];
    NSLog(@"%@",titile);
    cell.textLabel.text = titile;
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
