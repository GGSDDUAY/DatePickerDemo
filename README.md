# DatePickerDemo
用户选择年月，年，起止年的控件。
#用法
- 选择月

```
LODateYearPicker *picker = [[LODateYearPicker alloc]init];
            [picker showWithYear:_year block:^(BOOL isCancel, NSInteger year) {
                if (!isCancel) {
                    
                }else{
                
                }
            }];

```

