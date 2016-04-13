## block
###作为变量
```
返回类型 (^block名)(参数类型) = ^返回类型(参数) {...};
  //声明一个block变量
    int(^myBlock)(int);
  //创建block
    myBlock = ^(int a){
        NSLog(@"参数：%d",a);
        return 10;
    };
  //调用
    myBlock(5);   
```
###作为属性(block为属性时要注意循环引用)
```
@property (nonatomic, copy) 返回类型 (^block名)(参数类型);
```
###作为方法参数
- 声明

```
- (void)someMethodThatTakesABlock:(返回类型 (^)(参数类型))block名;
//方法和block声明
- (void)takesABlock:(int (^)(int a,int b))aBlock;
//方法实现,block调用
-(void)takesABlock:(int (^)(int a, int b))aBlock{
    if (aBlock) {
        aBlock(10,11);
    }
}
```
- 调用

```
[someObject someMethodThatTakesABlock: ^返回类型 (参数) {...}];
//方法调用和block实现
[mainVC takesABlock:^int(int a, int b) {
        mainVC.view.backgroundColor = [UIColor greenColor];
        NSLog(@"takesABlock--a = %i,b = %i",a,b);
        return a+b;
    }];
```
###typedef

```
typedef 返回类型 (^类型)(参数类型);
类型 类型名 = ^返回类型(参数) {...};
```
###__block
>如果要在block内部引用外部变量,需要用__block修饰变量;
>
>block实现时,self的使用要注意,应该定义一个__block修饰的指针,例如:

```
__block UIViewController *viewcontroler = self;
button.block = ^(BlockButton *btn){
//block将当前对象self， retain了一下
[viewcontroler dismissModalViewControllerAnimated:YES];
    };

```
