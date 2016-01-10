## NSString和NSMutableString
___
### 创建
1.类方法
``` cpp
+ (instancetype)string;//创建一个空字符串
+ (instancetype)stringWithString:(NSString *)string;
+ (instancetype)stringWithCharacters:(const unichar *)characters length:(NSUInteger)length;
+ (nullable instancetype)stringWithUTF8String:(const char *)nullTerminatedCString;
+ (instancetype)stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (instancetype)localizedStringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)-----本地化字符串方法
+ (nullable instancetype)stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc;
+ (nullable instancetype)stringWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc error:(NSError **)error;
+ (nullable instancetype)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error;
+ (nullable id)stringWithContentsOfFile:(NSString *)path NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);
+ (nullable id)stringWithContentsOfURL:(NSURL *)url NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);
+ (nullable id)stringWithCString:(const char *)bytes length:(NSUInteger)length NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);
+ (nullable id)stringWithCString:(const char *)bytes NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);

```

2.实例化方法(对应类方法,有相应的实例化方法,不再罗列)
``` cpp
- (nullable instancetype)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;
- (nullable instancetype)initWithBytes:(const void *)bytes length:(NSUInteger)len encoding:(NSStringEncoding)encoding;
- (nullable instancetype)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)len encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)freeBuffer;	/* "NoCopy" is a hint */

```
### 字符串操作
- NSMutalbleString方法

``` cpp
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;//插入
- (void)deleteCharactersInRange:(NSRange)range;//删除
- (void)appendString:(NSString *)aString;//追加
- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);//追加格式化字符串
- (void)setString:(NSString *)aString;//赋值字符串
- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;
```
- 提取字符串

``` cpp
- (NSString *)substringFromIndex:(NSUInteger)from;//从第几个字符到最后包含第几个
- (NSString *)substringToIndex:(NSUInteger)to;//从头到第几个,不包含第几个
- (NSString *)substringWithRange:(NSRange)range;
- (NSArray<NSString *> *)componentsSeparatedByString:(NSString *)separator;
- (NSArray<NSString *> *)componentsSeparatedByCharactersInSet:(NSCharacterSet *)separator

```


- 查找字符串(NSRange:location和length)

```cpp
- (NSRange)rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask;
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)searchSet options:(NSStringCompareOptions)mask;
- (NSRange)rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index;

```
- 字符串转换

```cpp
-(NSString *)uppercaseString;
-(NSString *)lowercaseString;
-(NSString *)capitalizedString;
-(const char *)UTF8String;
-(double)doubleValue;
-(float)floatValue;
-(NSInteger)integerValue;
-(int)Value ;

```



- 字符串比较

```cpp
- (BOOL)isEqualToString:(NSString *)str; 
- (NSComparisonResult)compare:(NSString *)string;
- (NSComparisonResult)caseInsensitiveCompare:(NSString *)string;
- (NSComparisonResult)localizedCompare:(NSString *)string;

```


- 字符串包含

```cpp
  //测试字符串开头结尾 
- (BOOL)hasPrefix:(NSString *)str;
- (BOOL)hasSuffix:(NSString *)str;
  //是否包含某字符串
- (BOOL)containsString:(NSString *)str NS_AVAILABLE(10_10, 8_0);
- (BOOL)localizedCaseInsensitiveContainsString:(NSString *)str NS_AVAILABLE(10_10, 8_0);   
- (BOOL)localizedStandardContainsString:(NSString *)str NS_AVAILABLE(10_11, 9_0);

```
