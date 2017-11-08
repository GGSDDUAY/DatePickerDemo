# DatePickerDemo
用户选择年月，年，起止年的控件。

#DatePickerViewConstant.h
用到的常量，变量，block等的定义

#用法
- 选择年

```
LODateYearPicker *picker = [[LODateYearPicker alloc]init];
[picker showWithYear:2017 block:^(BOOL isCancel, NSInteger year) {
    if (!isCancel) {
        
    }else{
    
    }
}];

```




