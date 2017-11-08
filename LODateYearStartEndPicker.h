//
//  LODateYearStartEndPicker.h
//  LaiOManagerIphone
//
//  Created by ChenZhiCheng on 2017/8/17.
//  Copyright © 2017年 dadahua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewConstant.h"

///选择起止年
@interface LODateYearStartEndPicker : UIView
- (void)showWithYear1:(NSInteger)year1 year2:(NSInteger)year2 block:(LODateYearStartEndPickerBlock)block;
@end
