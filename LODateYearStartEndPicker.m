//
//  LODateYearStartEndPicker.m
//  LaiOManagerIphone
//
//  Created by ChenZhiCheng on 2017/8/17.
//  Copyright © 2017年 dadahua. All rights reserved.
//


#import "LODateYearStartEndPicker.h"


@interface  LODateYearStartEndPicker()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *_bgView;

    NSInteger _year1;
    NSInteger _year2;
    
    UIPickerView *_pickerViewLeft;
    UIPickerView *_pickerViewRight;
}
@property (nonatomic, copy) LODateYearStartEndPickerBlock block;
@property (nonatomic, strong) UIView *topTitleView;
@property (nonatomic, strong) UIView *datePickerView;
@property (nonatomic, strong) UIView *buttonView;
@end
@implementation LODateYearStartEndPicker

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (NSInteger)getRowWithYear:(NSInteger)year{
    if (year > DatePickerEndYear) {
        return DatePickerEndYear - DatePickerStartYear;
    }else{
        if (year < DatePickerStartYear) {
            return 0;
        }else{
            return year - DatePickerStartYear;
        }
    }
}
- (void)showWithYear1:(NSInteger)year1 year2:(NSInteger)year2 block:(LODateYearStartEndPickerBlock)block{
    _year1 = year1;
    _year2 = year2;
    
    [_pickerViewLeft selectRow:[self getRowWithYear:year1] inComponent:0 animated:YES];
    [_pickerViewRight selectRow:[self getRowWithYear:year2] inComponent:0 animated:YES];
    
    _block = block;
    _bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
    [_bgView addGestureRecognizer:tap];
    _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    self.backgroundColor = DatePickerContentBgColor;
    self.layer.borderColor = DatePickerContentBgColor.CGColor;
    self.layer.cornerRadius = 3.0f;
    self.layer.masksToBounds = YES;
    self.layer.shadowColor = DatePickerContentBgColor.CGColor;
    
    CGFloat height = DatePickerLabelHeight + DatePickerHeight + DatePickerButtonHeight + 2;
    self.frame = CGRectMake(DatePickerPadding, DatePickerScreenH, DatePickerScreenW - 2 *DatePickerPadding, height);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(DatePickerPadding, DatePickerScreenH - height - DatePickerPadding - kTabBarOffSetHeight, DatePickerScreenW - 2 *DatePickerPadding, height);

    }];
    
}

- (void)initView{
    

    CGFloat width = DatePickerScreenW - 2 * DatePickerPadding;
    _topTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5,width, DatePickerLabelHeight)];
    _topTitleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topTitleView];
    
    _datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topTitleView.frame) + 0.5, width, DatePickerHeight)];
    _datePickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_datePickerView];
    
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_datePickerView.frame) + 0.5, width, DatePickerButtonHeight)];
    [self addSubview:_buttonView];
    _buttonView.backgroundColor = DatePickerContentBgColor;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width / 2.0f, DatePickerLabelHeight)];
    label1.text = DatePickerStartYearString;
    [_topTitleView addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, width / 2.0f, DatePickerLabelHeight)];
    label2.text = DatePickerEndYearString;
    [_topTitleView addSubview:label2];
    
    label1.textAlignment =
    label2.textAlignment = NSTextAlignmentCenter;
    
    label1.font =
    label2.font = [UIFont systemFontOfSize:14];

    UIPickerView *pickerViewLeft = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, width / 2.0f, DatePickerHeight)];
    _pickerViewLeft = pickerViewLeft;
    pickerViewLeft.delegate = self;
    pickerViewLeft.dataSource = self;
    [_datePickerView addSubview:pickerViewLeft];
    pickerViewLeft.showsSelectionIndicator = NO;
    
    UIPickerView *pickerViewRight = [[UIPickerView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pickerViewLeft.frame), 0, width / 2.0f, DatePickerHeight)];
    _pickerViewRight = pickerViewRight;
    pickerViewRight.delegate = self;
    pickerViewRight.dataSource = self;
    [_datePickerView addSubview:pickerViewRight];
    pickerViewRight.showsSelectionIndicator = NO;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width / 2.0f - 0.25, DatePickerButtonHeight)];
    [_buttonView addSubview:btn1];
    btn1.backgroundColor = DatePickerButtonBgColor;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:DatePickerCancelButtonTitle forState:UIControlStateNormal];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width / 2.0f + 0.25, 0, width / 2.0f - 0.25, DatePickerButtonHeight)];
    [_buttonView addSubview:btn2];
    btn2.backgroundColor = DatePickerButtonBgColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:DatePickerSureButtonTitle forState:UIControlStateNormal];
    
    
    btn1.titleLabel.font =
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel{
    if (_block) {
        _block(YES,_year1,_year2);
    }
    [self dismiss];
}
- (void)sure{
    if (_block) {
        _block(NO,_year1,_year2);
    }
    [self dismiss];
}
- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = DatePickerScreenH;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        [_bgView removeFromSuperview];
    }];
    
}
- (NSInteger)getYearWithComponent:(NSInteger)component row:(NSInteger)row{
    return DatePickerStartYear + row;
}
- (NSInteger)getNumRows{
    return DatePickerEndYear - DatePickerStartYear + 1;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self getNumRows];
}
// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (DatePickerScreenW - 2 * DatePickerPadding) / 2.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return DatePickerRowHeight;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [NSString stringWithFormat:@"%ld年",(long)[self getYearWithComponent:component row:row]];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _pickerViewLeft) {
        //start
        if ([self getYearWithComponent:component row:row] >= _year2) {
            if ([self getRowWithYear:_year2] == 0) {
                [_pickerViewLeft selectRow:0 inComponent:0 animated:YES];
                _year1 = _year2;
            }else{
                [_pickerViewLeft selectRow:[self getRowWithYear:_year2 - 1] inComponent:0 animated:YES];
                _year1 = _year2 - 1;
            }
        }else{
            _year1 = [self getYearWithComponent:component row:row];
        }
    }else{
        //end
        if ([self getYearWithComponent:component row:row] <= _year1) {
            if ([self getRowWithYear:_year1] == [self getNumRows] - 1) {
                _year2 = _year1;
                [_pickerViewRight selectRow:[self getRowWithYear:_year1] inComponent:0 animated:YES];
            }else{
                [_pickerViewRight selectRow:[self getRowWithYear:_year1] + 1 inComponent:0 animated:YES];
                _year2 = _year1 + 1;
            }
        }else{
            _year2 = [self getYearWithComponent:component row:row];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
