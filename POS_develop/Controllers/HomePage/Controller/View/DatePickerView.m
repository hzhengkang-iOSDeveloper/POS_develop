//
//  DatePickerView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "DatePickerView.h"
@interface DatePickerView ()
@property (nonatomic, assign) NSUInteger selectedCount;

@end
@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.selectedCount = 0;
    }
    return self;
}

- (void)initUI {
//    self.backgroundColor = WhiteColor;
    self.startTimeTF = [[UITextField alloc] init];
    self.startTimeTF.placeholder = @"开始时间";
    self.startTimeTF.textAlignment = NSTextAlignmentCenter;
    self.startTimeTF.textColor = C000000;
    self.startTimeTF.font = F13;
    //    self.startTimeTF.borderStyle = UITextBorderStylel;
    [self addSubview:self.startTimeTF];
    [_startTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AD_HEIGHT(25));
        make.top.equalTo(self).offset(AD_HEIGHT(11));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(142), AD_HEIGHT(29)));
    }];
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"至";
    textLabel.textColor = C000000;
    textLabel.font = F13;
    textLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.startTimeTF.mas_centerY);
        make.height.mas_equalTo(AD_HEIGHT(12));
    }];
    self.endTimeTF = [[UITextField alloc] init];
    self.endTimeTF.placeholder = @"结束时间";
    self.endTimeTF.textAlignment = NSTextAlignmentCenter;
    self.endTimeTF.textColor = C000000;
    self.endTimeTF.font = F13;
    //    self.endTimeTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.endTimeTF];
    [_endTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(AD_HEIGHT(-25));
        make.top.equalTo(self).offset(AD_HEIGHT(11));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(142), AD_HEIGHT(29)));
    }];
    [self solveBorderWithView:self.startTimeTF];
    [self solveBorderWithView:self.endTimeTF];
    
    [self creatDatePickerWithTextField];

}
#pragma mark ---- 添加时间选择器
-(void)creatDatePickerWithTextField
{
    //当文本框成为第一响应者调出事件选择器
    
    
//    self.startTimeTF.delegate = self;
//    self.endTimeTF.delegate = self;
    
    
    self.FirstDatePicker  = [[UIDatePicker alloc]init];
    
    
    self.startTimeTF.inputView = self.FirstDatePicker;
    //设置只显示中文
    [self.FirstDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    
    
    //设置只显示日期
    [self.FirstDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    //添加监听器
    [self.FirstDatePicker addTarget:self action:@selector(selectFirstDatePicker:) forControlEvents:UIControlEventAllEvents];
    
    //创建工具条ToolBar
    _FirstToolBar  = [[UIToolbar alloc]init];
    
    //设置工具条的颜色
    _FirstToolBar.barTintColor = C1E95F9;
    
    //设置工具条frame
    _FirstToolBar.frame        = CGRectMake(0, 0, ScreenWidth, FITiPhone6(45));
    
    //给工具条添加按钮
    //    UIBarButtonItem * itemA = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickToolBarBtn:)];
    //    itemA.tag = 100;
    //    [itemA setTintColor:C000000];
    UIBarButtonItem * itemB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * itemC = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(clickToolBarBtn:)];
    itemC.tag = 101;
    [itemC setTintColor:WhiteColor];
    
    _FirstToolBar.items = @[itemB,itemC];
    
    self.startTimeTF.inputAccessoryView = _FirstToolBar;
    
    
    //创建SecondDatePicker
    self.SecondDatePicker  = [[UIDatePicker alloc]init];
    
    
    self.endTimeTF.inputView = self.SecondDatePicker;
    //设置只显示中文
    [self.SecondDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    
    //设置只显示日期
    [self.SecondDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    //添加监听器
    [self.SecondDatePicker addTarget:self action:@selector(selectLastDatePicker:) forControlEvents:UIControlEventAllEvents];
    
    self.endTimeTF.inputAccessoryView = _FirstToolBar;
    
    
}
#pragma mark ----- 监听DatePicker
-(void)selectFirstDatePicker:(UIDatePicker *)sender{
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.datePickerStrA = dateStr;
    
}
-(void)selectLastDatePicker:(UIDatePicker *)sender{
    
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.datePickerStrB = dateStr;
}

#pragma mark ---- 按钮显示逻辑 ----
- (void)changeBtn
{
    self.selectedCount ++;
    if (self.selectedCount >1) {
        if (self.agentOrPersonIsSelected) {
            if (self.backVcChangeBtn) {
                self.backVcChangeBtn();
            }
        } else {
            if (self.clcikDateSelected) {
                self.clcikDateSelected(YES);
            }
        }
    }
}


#pragma mark ----- 工具条点击事件
-(void)clickToolBarBtn:(UIBarButtonItem *)item
{
    if ([self.startTimeTF isFirstResponder]) {
        if (item.tag-100 == 1) {
            if ([self.datePickerStrA isEqualToString:@""]||self.datePickerStrA == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy/MM/dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.startTimeTF setFont:[UIFont systemFontOfSize:14]];
                self.startTimeTF.text = dateStr;
                self.datePickerStrA = dateStr;
            }else{
                self.startTimeTF.text = self.datePickerStrA;
            }
            
        }
        [self.startTimeTF resignFirstResponder];
    }else
    {
        if (item.tag-100 == 1) {
            if ([self.datePickerStrB isEqualToString:@""]||self.datePickerStrB == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy/MM/dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.endTimeTF setFont:[UIFont systemFontOfSize:14]];
                self.endTimeTF.text = dateStr;
                self.datePickerStrB = dateStr;
            }else{
                self.endTimeTF.text = self.datePickerStrB;
            }
            
        }
        [self.endTimeTF resignFirstResponder];
    }
    
    [self changeBtn];
    
    
}

#pragma mark ---- 优化边框
-(void)solveBorderWithView:(UIView *)view
{
    view.layer.borderColor = [RGB(149, 149, 149) CGColor];
    view.layer.borderWidth = 0.5f;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius  = 5.0f;
}
                
@end
