//
//  LODateYearPicker.h
//  LaiOManagerIphone
//
//  Created by ChenZhiCheng on 2017/8/17.
//  Copyright © 2017年 dadahua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewConstant.h"


///选择年
@interface LODateYearPicker : UIView

- (void)showWithYear:(NSInteger)year block:(LODateYearPickerBlock)block;

@end
