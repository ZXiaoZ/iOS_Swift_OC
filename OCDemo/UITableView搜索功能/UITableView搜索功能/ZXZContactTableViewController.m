//
//  ZXZContactTableViewController.m
//  UITableView搜索功能
//
//  Created by zxz on 15/11/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "ZXZContactTableViewController.h"
#import "ZXZContact.h"
#import "ZXZContactGroup.h"

#define kSearchbarHeight 44

@interface ZXZContactTableViewController ()
{
    UITableView *_tableView;
    UISearchBar *_searchBar;
    //UISearchDisplayController *_searchDisplayController;
    NSMutableArray *_contacts;//联系人模型
    NSMutableArray *_searchContacts;//符合条件的搜索联系人
    BOOL _isSearching;
}

@end

@implementation ZXZContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    
    //添加搜索框
    [self addSearchBar];
    
   
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSearching) {
        return 1;
    }
    return _contacts.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearching) {
        return _searchContacts.count;
    }
    ZXZContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXZContact *contact=nil;
    
    if (_isSearching) {
        contact=_searchContacts[indexPath.row];
    }else{
        ZXZContactGroup *group=_contacts[indexPath.section];
        contact=group.contacts[indexPath.row];
    }
    
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
    
    return cell;
}
#pragma mark - 搜索框代理
#pragma mark  取消搜索
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isSearching=NO;
    _searchBar.text=@"";
    [self.tableView reloadData];
}

#pragma mark 输入搜索关键字
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([_searchBar.text isEqual:@""]){
        _isSearching=NO;
        [self.tableView reloadData];
        return;
    }
    [self searchDataWithKeyWord:_searchBar.text];
}

#pragma mark 点击虚拟键盘上的搜索时
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self searchDataWithKeyWord:_searchBar.text];
    
    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
}




#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    
    ZXZContact *contact1=[ZXZContact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    ZXZContact *contact2=[ZXZContact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    ZXZContactGroup *group1=[ZXZContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    ZXZContact *contact3=[ZXZContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    ZXZContact *contact4=[ZXZContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    ZXZContact *contact5=[ZXZContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    ZXZContactGroup *group2=[ZXZContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    ZXZContact *contact6=[ZXZContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    ZXZContact *contact7=[ZXZContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
    
    ZXZContactGroup *group3=[ZXZContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    ZXZContact *contact8=[ZXZContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    ZXZContact *contact9=[ZXZContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    ZXZContact *contact10=[ZXZContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    ZXZContact *contact11=[ZXZContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    ZXZContact *contact12=[ZXZContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    ZXZContactGroup *group4=[ZXZContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    ZXZContact *contact13=[ZXZContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    ZXZContact *contact14=[ZXZContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    ZXZContact *contact15=[ZXZContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ZXZContactGroup *group5=[ZXZContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
    
}
#pragma mark 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord{
    _isSearching=YES;
    _searchContacts=[NSMutableArray array];
    [_contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZXZContactGroup *group=obj;
        [group.contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ZXZContact *contact=obj;
            if ([contact.firstName.uppercaseString containsString:keyWord.uppercaseString]||[contact.lastName.uppercaseString containsString:keyWord.uppercaseString]||[contact.phoneNumber containsString:keyWord]) {
                [_searchContacts addObject:contact];
            }
        }];
    }];
    
    //刷新表格
    [self.tableView reloadData];
}
#pragma mark 添加搜索栏
-(void)addSearchBar{
    CGRect searchBarRect=CGRectMake(0, 0, self.view.frame.size.width, kSearchbarHeight);
    _searchBar=[[UISearchBar alloc]initWithFrame:searchBarRect];
    _searchBar.placeholder=@"Please input key word...";
    //_searchBar.keyboardType=UIKeyboardTypeAlphabet;//键盘类型
    //_searchBar.autocorrectionType=UITextAutocorrectionTypeNo;//自动纠错类型
    //_searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;//哪一次shitf被自动按下
    _searchBar.showsCancelButton=YES;//显示取消按钮
    //添加搜索框到页眉位置
    _searchBar.delegate=self;
    self.tableView.tableHeaderView=_searchBar;
}


@end
