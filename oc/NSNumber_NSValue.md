## NSNumber和NSValue
___
###NSNubmer(NSNumber可以将数字包装为对象)

```
NSNumber *myNumber,*floatNumber,*intNumber,*number1;  
//创建integer类型对象  
intNumber = [NSNumber numberWithInteger:123];  
//创建long类型对象  
myNumber = [NSNumber numberWithLong:0xababab];  
//创建char类型对象  
myNumber = [NSNumber numberWithChar:'K'];    
//创建float类型对象  
floatNumber = [NSNumber numberWithFloat:123.00];  
//创建double类型对象  
myNumber = [NSNumber numberWithDouble:112233e+15];  
//判断两个对象的值是否相等  
if ([intNumber isEqualToNumber:floatNumber] == YES ) {  
   NSLog(@"值相等");  
} else {  
   NSLog(@"值不相等");  
}  
//比较两个对象的值大小  
if ( [intNumber compare:myNumber] == NSOrderedAscending) {  
   NSLog(@"左边的数字小");  
} else {  
   NSLog(@"左边的数字大");  
}  
```
###NSValue(可以封装任意数据类型为对象)
- 结构体封装

```
typedef struct  
{  
    int    id;  
    float  height;  
    unsigned char   flag;  
} MyTestStruct;  
MyTestStruct myTestSturct;  
myTestSturct.id = 1;  
myTestSturct.height = 23.0;  
myTestSturct.flag = 'A';  
//封装数据  
NSValue *value = [NSValue valueWithBytes:&myTestSturct objCType:@encode(MyTestStruct)];  
//取出value中的数据  
MyTestStruct  theTestStruct;  
  
[value getValue:&theTestStruct];//可对theTestStruct操作取得其中的数据

```
- 常用方法

```
+ (NSValue *)valueWithNonretainedObject:(nullable id)anObject;
@property (nullable, readonly) id nonretainedObjectValue;

+ (NSValue *)valueWithPointer:(nullable const void *)pointer;
@property (nullable, readonly) void *pointerValue;

- (BOOL)isEqualToValue:(NSValue *)value;
+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGVector:(CGVector)vector;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;

```