//
//  SheetPickerView.m
//  inspection
//
//  Created by fengjie on 16/9/7.
//  Copyright © 2016年 fengjie. All rights reserved.
//

#import "SheetPickerView.h"

@interface SheetPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) UIView *bgView;    //屏幕下方看不到的view
@property (weak, nonatomic) UILabel *titleLabel; //中间显示的标题lab
@property (weak, nonatomic) UIPickerView *pickerView;
@property (weak, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) NSMutableArray *dataArray;   // 用来记录传递过来的数组数据
@property (strong, nonatomic) NSString *headTitle;  //传递过来的标题头字符串
@property (strong, nonatomic) NSString *backString; //回调的字符串

@end

@implementation SheetPickerView
{
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *monthMutableArray;
    NSMutableArray *DaysMutableArray;
    NSMutableArray *DaysArray;
    NSString *currentyearString;
    NSString *currentMonthString;
    NSString *currentDateString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
    
}

+(instancetype)SheetStringPickerWithTitle:(NSMutableArray *)title andHeadTitle:(NSString *)headTitle  withIsDatePicker:(BOOL)isDatePicker Andcall:(SheetPickerViewBlock)callBack
{
    SheetPickerView *pickerView = [[SheetPickerView alloc]initWithFrame:[UIScreen mainScreen].bounds andTitle:title andHeadTitle:headTitle withIsDatePicker:isDatePicker];
    pickerView.callBack = callBack;
    return pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSMutableArray *)title andHeadTitle:(NSString *)headTitle withIsDatePicker:(BOOL)isDatePicker
{
    self = [super initWithFrame:frame];
    if (self) {
        _headTitle = headTitle;
        _backString = @"";
        self.isDatePicker = isDatePicker;
        _dataArray = [NSMutableArray arrayWithArray:title];
        [self setupUI];

        if (!isDatePicker) {
            [self initPickerViewSelected];
        } else {
            [self setupDatas];
            [self initPickerViewDatas];

        }
        
    }
    return self;
}

- (void)tap {
    [self dismissPicker];
}

- (void)setupUI
{
    
    // 首先创建一个位于屏幕下方看不到的view
    UIView* bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    bgView.alpha = 0.0f;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [bgView addGestureRecognizer:g];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    self.bgView = bgView;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    topView.backgroundColor = C1E95F9;
    [self addSubview:topView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 75, 5, 150, 40)];
    titleLabel.font = F13;
    titleLabel.textColor = WhiteColor;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:_headTitle];
    [titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    //选择器
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(5, 22, ScreenWidth - 5, 230)];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(2, 5, ScreenWidth * 0.25, 40);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"关闭" attributes:
                                      @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                         NSFontAttributeName :           [UIFont systemFontOfSize:FITiPhone6(13)],
                                         NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [cancelButton setAttributedTitle:attrString forState:UIControlStateNormal];
    cancelButton.adjustsImageWhenHighlighted = NO;
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    self.cancelButton = cancelButton;
    
    // 完成按钮
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(ScreenWidth - ScreenWidth * 0.25-2, 5, ScreenWidth * 0.25, 40);
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"确认" attributes:
                                       @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSFontAttributeName :           [UIFont systemFontOfSize:FITiPhone6(13)],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [doneButton setAttributedTitle:attrString2 forState:UIControlStateNormal];
    doneButton.adjustsImageWhenHighlighted = NO;
    doneButton.backgroundColor = [UIColor clearColor];
    [doneButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneButton];
    self.doneButton = doneButton;

    
    // self
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, ScreenWidth - 300, ScreenWidth, 300)];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    [self setFrame: CGRectMake(0, ScreenWidth, ScreenWidth, 250)];
}

- (void)setupDatas {
    m = 0;
    firstTimeLoad = YES;
    
    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    currentyearString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    year = [currentyearString intValue];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date] integerValue]];
    month = [currentMonthString intValue];
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    currentDateString = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    day = [currentDateString intValue];
    
    yearArray = [[NSMutableArray alloc] init];
    monthMutableArray = [[NSMutableArray alloc] init];
    DaysMutableArray= [[NSMutableArray alloc] init];
    for (int i = 1940; i <= year; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    
    // PickerView -  Months data
    
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    for (int i = 1; i < month + 1; i++) {
        [monthMutableArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    DaysArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 31; i++) {
        [DaysArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    for (int i = 1; i < day + 1; i++) {
        [DaysMutableArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

- (void)initPickerViewDatas {
    // PickerView - Default Selection as per current Date
    // 设置初始默认值
    [self.pickerView selectRow:[yearArray indexOfObject:[NSString stringWithFormat:@"%d", [currentyearString intValue] - 16]] inComponent:0 animated:YES];
    
    [self.pickerView selectRow:[monthArray indexOfObject:@"1"] inComponent:1 animated:YES];
    
    // 将前面的0处理掉
    int dateStr = [currentDateString intValue];
    currentDateString = [NSString stringWithFormat:@"%d",dateStr];
    [self.pickerView selectRow:[DaysArray indexOfObject:@"1"] inComponent:2 animated:YES];
}

- (void)initPickerViewSelected {
    // PickerView - Default Selection as per current Date
    // 设置初始默认值
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
}

- (void)clicked:(UIButton *)sender
{
    if ([sender isEqual:self.cancelButton]) {
        [self dismissPicker];
    } else {
        if (self.isDatePicker) {
            NSString *yearStr = [yearArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            NSString *monthStr = [monthArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
            NSString *dayStr = [DaysArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
            
            if ([monthStr intValue] < 10) {
                monthStr = [NSString stringWithFormat:@"0%@", monthStr];
            }
            
            if ([dayStr intValue] < 10) {
                dayStr = [NSString stringWithFormat:@"0%@", dayStr];
            }
            
            _backString = [NSString stringWithFormat:@"%@%@%@", yearStr, monthStr, dayStr];
            if (self.callBack) {
                self.callBack(self,_backString);
            }
        } else {
            _backString = [self.dataArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            if (self.callBack) {
                self.callBack(self,_backString);
            }
        }
       
    }
}


#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.isDatePicker) {
        return 3;
    }
    return 1;
}

#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isDatePicker) {
        if (component == 0) {
            return [yearArray count];
        } else if (component == 1) {
            NSInteger selectRow =  [pickerView selectedRowInComponent:0];
            int n;
            n = year - 1940;
            if (selectRow == n) {
                return [monthMutableArray count];
            } else {
                return [monthArray count];
            }
        } else {
            NSInteger selectRow1 =  [pickerView selectedRowInComponent:0];
            int n;
            n = year - 1940;
            NSInteger selectRow = [pickerView selectedRowInComponent:1];
            
            if (selectRow == month - 1 & selectRow1 == n) {
                return day;
            } else {
                if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11) {
                    return 31;
                } else if (selectedMonthRow == 1) {
                    int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                    
                    if(((yearint % 4 == 0)&&(yearint % 100 != 0))||(yearint % 400 == 0)){
                        return 29;
                    } else {
                        return 28; // or return 29
                    }
                } else {
                    return 30;
                }
            }
        }
    } else {
        return _dataArray.count;
    }
    
}

#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.isDatePicker) {
        m = row;
        
        if (component == 0) {
            selectedYearRow = row;
            [self.pickerView reloadAllComponents];
        } else if (component == 1) {
            selectedMonthRow = row;
            [self.pickerView reloadAllComponents];
        } else if (component == 2) {
            selectedDayRow = row;
            
            [self.pickerView reloadAllComponents];
        }
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 100, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    if (self.isDatePicker) {
        if (component == 0) {
            pickerLabel.text =  [NSString stringWithFormat:@"%@年",[yearArray objectAtIndex:row]]; // Year
        } else if (component == 1) {
            pickerLabel.text =  [NSString stringWithFormat:@"%@月",[monthArray objectAtIndex:row]];  // Month
        } else if (component == 2) {
            pickerLabel.text =  [NSString stringWithFormat:@"%@日",[DaysArray objectAtIndex:row]]; // Date
        }
    } else {
        pickerLabel.text =  [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:row]]; // Date
    }
    
    
    return pickerLabel;
}

- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (void)show {
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    self.bgView.alpha = 1.0;
    self.frame = CGRectMake(0, ScreenHeight - 250, ScreenWidth, 250);

    self.transform = CGAffineTransformMakeTranslation(0.01, ScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
        
    }];
//    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
//
//        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
//        self.bgView.alpha = 1.0;
//        self.frame = CGRectMake(0, ScreenHeight - 250, ScreenWidth, 250);
//
//    } completion:NULL];
}

- (void)dismissPicker {
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        self.bgView.alpha = 0.0;
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


@end
