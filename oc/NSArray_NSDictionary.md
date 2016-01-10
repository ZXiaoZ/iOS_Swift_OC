## NSArray和NSDictionary
___
  >NSArray和NSDictionary只能存放对象,基本数据类型可以加'@'存入;
  >
  > 数组中的元素后面必须加nil以表示数据结束；
  
###常用方法
```
//创建
+ (instancetype)arrayWithObjects:(ObjectType)firstObj, ... 
+ (instancetype)arrayWithArray:(NSArray<ObjectType> *)array;
- (NSArray<ObjectType> *)arrayByAddingObject:(ObjectType)anObject;
//查找
- (BOOL)containsObject:(ObjectType)anObject;
- (NSUInteger)indexOfObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)objectsAtIndexes:(NSIndexSet *)indexes;

//保存
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically;
+ (nullable NSArray<ObjectType> *)arrayWithContentsOfFile:(NSString *)path;
//元素操作
- (NSString *)componentsJoinedByString:(NSString *)separator;
- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(nullable id)argument ;
//NSMutableArray
- (void)addObject:(ObjectType)anObject;
- (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;
```
###排序和遍历

```cpp
    //使用自带的比较器
    NSArray *array=[NSArray arrayWithObjects:@"3",@"1",@"2", nil];
    NSArray *array2= [array sortedArrayUsingSelector:@selector(compare:)];
    //自己定义比较器
    NSArray *array3=[NSArray arrayWithObjects:obj1,obj2,obj3, nil];
    NSArray *array4=[array3 sortedArrayUsingSelector:@selector(compareObj:)];
    //使用代码块
    NSArray *array5=[array3 sortedArrayUsingComparator:^NSComparisonResult(Obj *obj1, Obj *obj2) {
        return [obj2.name compare:obj1.name];//默认降序降序
    }];
    //通过描述器定义排序规则
    NSArray *array6=[NSArray arrayWithObjects:person4,person5,person6,person7, nil];
    //定义一个排序描述
    NSSortDescriptor *personName=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *accountBalance=[NSSortDescriptor sortDescriptorWithKey:@"account.balance" ascending:YES];
    NSArray *des=[NSArray arrayWithObjects:personName,accountBalance, nil];//先按照person的name排序再按照account的balance排序
    NSArray *array7=[array6 sortedArrayUsingDescriptors:des];

```
###去重

```
//字典方法 
NSArray *arr = @[@111,@222,@111];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSNumber *number in arr) {
        [dict setObject:number forKey:number];
    }
//集合法
 NSArray *arr = @[@111,@222,@111];
    NSSet *set = [NSSet setWithArray:arr];
//数组方法
NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [nameArray count]; i++){
        if ([categoryArray containsObject:[nameArray objectAtIndex:i]] == NO){
            [categoryArray addObject:[nameArray objectAtIndex:i]];
        }
    }
    
```
