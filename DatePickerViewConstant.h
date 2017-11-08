//
//  DatePickerViewConstant.h
//  LaiOManagerIphone
//
//  Created by ChenZhiCheng on 2017/8/18.
//  Copyright © 2017年 dadahua. All rights reserved.
//

#ifndef DatePickerViewConstant_h
#define DatePickerViewConstant_h

#pragma mark - 日期
///当前时间
#define DatePickerDateNow [NSDate date]

#pragma mark - 颜色
///填充容器的颜色（线的颜色）
#define DatePickerContentBgColor  [UIColor colorWithWhite:0.8 alpha:1]
///按钮的背景色
#define DatePickerButtonBgColor  [UIColor groupTableViewBackgroundColor]
//[UIColor colorWithWhite:0.9 alpha:1]

#pragma mark - 年份
/// 开始年份
#define DatePickerStartYear 2016
///截至年份
#define DatePickerEndYear DatePickerDateNow.year


#pragma mark - 文字
///提示文字，开始年份
#define DatePickerStartYearString @"开始年份"
///提示文字，截至年份
#define DatePickerEndYearString  @"截至年份"
///按钮文字，取消
#define DatePickerCancelButtonTitle @"取消"
///按钮文字，确定
#define DatePickerSureButtonTitle @"确定"

#pragma mark - 宽度，高度
///屏幕宽度
#define DatePickerScreenW CGRectGetWidth([UIScreen mainScreen].bounds)
///屏幕高度
#define DatePickerScreenH CGRectGetHeight([UIScreen mainScreen].bounds)

/// 高度常量，间距
static const CGFloat DatePickerPadding = 10;
/// 高度常量，提示文字label高度
static const CGFloat DatePickerLabelHeight = 40;
/// 高度常量，选择器高度
static const CGFloat DatePickerHeight = 150;
/// 高度常量，按钮高度
static const CGFloat DatePickerButtonHeight = 45;
/// 高度常量，选择器每行的高度
static const CGFloat DatePickerRowHeight = 50.0f;


#pragma mark - 回调Block
///选择开始年份，截至年份回调
typedef void(^LODateYearStartEndPickerBlock)( BOOL isCancel,NSInteger year1,NSInteger year2);
///选择年份回调
typedef void(^LODateYearPickerBlock)( BOOL isCancel,NSInteger year);
///选择年和月回调
typedef void(^LODateYearMonthPickerBlock)( BOOL isCancel,NSInteger year,NSInteger month);



#endif /* DatePickerViewConstant_h */
