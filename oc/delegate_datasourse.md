## delegate和datasourse
___
>两种方式传值有点不同,但官方也有双向传值的方式如:
>```
>- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
>```
>所以在遇到此类双向传值时要非常小心,因为会导致耦合;

###基本方法
- manager
  ```
1.创建协议
@protocol JobDelegate <NSObject>
-(void)workeTheJob:(NSString *)jobContentText;
@end
2.delegate属性
@interface ManagerViewController : UIViewController
@property (nonatomic,assign) id <JobDelegate> jobDeleage;
@end
3.内部调用
[_jobDelegate workeTheJob:_WorkerJobText.text]
  ```
- worker

  ```
1.实现协议
2.实现方法
3.manager.delegate = worker;
  ```