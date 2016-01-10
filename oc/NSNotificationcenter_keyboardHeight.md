## NSNotificationCenter获取键盘高度
___

- 常用方法

```
接收消息 ,先注册接收者    
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;
发送消息
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;
结束通知
-(void)invalid;
```
- 获取键盘高度


```
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

```