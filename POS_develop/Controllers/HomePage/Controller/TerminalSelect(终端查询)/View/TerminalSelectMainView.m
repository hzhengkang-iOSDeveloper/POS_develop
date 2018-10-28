//
//  TerminalSelectMainView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSelectMainView.h"

@interface TerminalSelectMainView ()
@property (strong , nonatomic)UIDatePicker * snStartDatePicker;
@property (strong , nonatomic)UIDatePicker * snEndDatePicker;
@property (strong , nonatomic)UIDatePicker * activationStartDatePicker;
@property (strong , nonatomic)UIDatePicker * activationEndDatePicker;
@property (copy   , nonatomic)NSString     * snDatePickerStrA;//记录SN datePicker上日期
@property (copy   , nonatomic)NSString     * snDdatePickerStrB;//记录SN datePicker上日期
@property (copy   , nonatomic)NSString     * activationDatePickerStrA;//记录activation datePicker上日期
@property (copy   , nonatomic)NSString     * activationDatePickerStrB;//记录activation datePicker上日期
@property (strong , nonatomic)UIToolbar * FirstToolBar;
@property (strong , nonatomic)UIToolbar * SecondToolBar;

@property (nonatomic, assign) NSUInteger selectedCount;


@end
@implementation TerminalSelectMainView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedCount = 0;

    [self initUI];

}

- (void)initUI {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查询条件(非必填)"];
    [str addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(4,str.length - 4)];
    self.conditionLabel.attributedText = str;
    
    [self solveBorderWithView:self.snStartTF];
    [self solveBorderWithView:self.snEndTF];
    [self solveBorderWithView:self.activationEndTF];
    [self solveBorderWithView:self.activationStartTF];
    
    [self creatDatePickerWithTextField];
    
}
#pragma mark ---- 添加时间选择器
-(void)creatDatePickerWithTextField
{
    //当文本框成为第一响应者调出事件选择器
    
    
    //    self.startTimeTF.delegate = self;
    //    self.endTimeTF.delegate = self;
    
    self.snStartDatePicker  = [[UIDatePicker alloc]init];
    self.snStartTF.inputView = self.snStartDatePicker;
    //设置只显示中文
    [self.snStartDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //设置只显示日期
    [self.snStartDatePicker setDatePickerMode:UIDatePickerModeDate];
    //添加监听器
    [self.snStartDatePicker addTarget:self action:@selector(selectFirstDatePicker:) forControlEvents:UIControlEventAllEvents];
    //创建工具条ToolBar
    _FirstToolBar  = [[UIToolbar alloc]init];
    _SecondToolBar = [[UIToolbar alloc] init];
    //设置工具条的颜色
    _FirstToolBar.barTintColor = C1E95F9;
    _SecondToolBar.barTintColor = C1E95F9;
    //设置工具条frame
    _FirstToolBar.frame        = CGRectMake(0, 0, ScreenWidth, FITiPhone6(45));
    _SecondToolBar.frame        = CGRectMake(0, 0, ScreenWidth, FITiPhone6(45));
    //给工具条添加按钮
    UIBarButtonItem * itemB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * itemC = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(clickToolBarBtn:)];
    itemC.tag = 101;
    [itemC setTintColor:WhiteColor];
    
    _FirstToolBar.items = @[itemB,itemC];
    
    self.snStartTF.inputAccessoryView = _FirstToolBar;
    
    
    //创建sn SecondDatePicker
    self.snEndDatePicker  = [[UIDatePicker alloc]init];
    self.snEndTF.inputView = self.snEndDatePicker;
    //设置只显示中文
    [self.snEndDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //设置只显示日期
    [self.snEndDatePicker setDatePickerMode:UIDatePickerModeDate];
    //添加监听器
    [self.snEndDatePicker addTarget:self action:@selector(selectLastDatePicker:) forControlEvents:UIControlEventAllEvents];
    self.snEndTF.inputAccessoryView = _FirstToolBar;
    
    
    //给工具条添加按钮
    UIBarButtonItem * itemD = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * itemE = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(clickSecondToolBarBtn:)];
    itemE.tag = 201;
    [itemE setTintColor:WhiteColor];
    
    _SecondToolBar.items = @[itemD,itemE];
    
    
    //创建activation StartDatePicker
    self.activationStartDatePicker  = [[UIDatePicker alloc]init];
    self.activationStartTF.inputView = self.activationStartDatePicker;
    //设置只显示中文
    [self.activationStartDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //设置只显示日期
    [self.activationStartDatePicker setDatePickerMode:UIDatePickerModeDate];
    //添加监听器
    [self.activationStartDatePicker addTarget:self action:@selector(selectActivationStartDatePicker:) forControlEvents:UIControlEventAllEvents];
    self.activationStartTF.inputAccessoryView = _SecondToolBar;
    
   

    
    //创建activation EndDatePicker
    self.activationEndDatePicker  = [[UIDatePicker alloc]init];
    self.activationEndTF.inputView = self.activationEndDatePicker;
    //设置只显示中文
    [self.activationEndDatePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //设置只显示日期
    [self.activationEndDatePicker setDatePickerMode:UIDatePickerModeDate];
    //添加监听器
    [self.activationEndDatePicker addTarget:self action:@selector(selectActivationEndDatePicker:) forControlEvents:UIControlEventAllEvents];
    self.activationEndTF.inputAccessoryView = _SecondToolBar;
}
#pragma mark ----- 监听DatePicker
-(void)selectFirstDatePicker:(UIDatePicker *)sender{
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.snDatePickerStrA = dateStr;
    
    
}
-(void)selectLastDatePicker:(UIDatePicker *)sender{
    
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.snDdatePickerStrB = dateStr;
}
-(void)selectActivationStartDatePicker:(UIDatePicker *)sender{
    
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.activationDatePickerStrA = dateStr;
}

-(void)selectActivationEndDatePicker:(UIDatePicker *)sender{
    
    //获取DatePicker上时间
    NSDate * selectDate = [sender date];
    
    //转换格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat =@"yyyy-MM-dd";
    
    NSString * dateStr = [dateFormatter stringFromDate:selectDate];
    
    self.activationDatePickerStrB = dateStr;
}

#pragma mark ----- 工具条点击事件
-(void)clickToolBarBtn:(UIBarButtonItem *)item
{
    if ([self.snStartTF isFirstResponder]) {
        if (item.tag-100 == 1) {
            if ([self.snDatePickerStrA isEqualToString:@""]||self.snDatePickerStrA == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy-MM-dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.snStartTF setFont:[UIFont systemFontOfSize:14]];
                self.snStartTF.text = dateStr;
                self.snDatePickerStrA = dateStr;
            }else{
                self.snStartTF.text = self.snDatePickerStrA;
            }
            
        }
        [self.snStartTF resignFirstResponder];
    }else
    {
        if (item.tag-100 == 1) {
            if ([self.snDdatePickerStrB isEqualToString:@""]||self.snDdatePickerStrB == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy-MM-dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.snEndTF setFont:[UIFont systemFontOfSize:14]];
                self.snEndTF.text = dateStr;
                self.snDdatePickerStrB = dateStr;
            }else{
                self.snEndTF.text = self.snDdatePickerStrB;
            }
            
        }
        [self.snEndTF resignFirstResponder];
    }
    
    
    
}
#pragma mark ----- 工具条点击事件
-(void)clickSecondToolBarBtn:(UIBarButtonItem *)item
{
    if ([self.activationStartTF isFirstResponder]) {
        if (item.tag-200 == 1) {
            if ([self.activationDatePickerStrA isEqualToString:@""]||self.activationDatePickerStrA == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy-MM-dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.activationStartTF setFont:[UIFont systemFontOfSize:14]];
                self.activationStartTF.text = dateStr;
                self.activationDatePickerStrA = dateStr;
            }else{
                self.activationStartTF.text = self.activationDatePickerStrA;
            }
            
        }
        [self.activationStartTF resignFirstResponder];
    }else
    {
        if (item.tag-200 == 1) {
            if ([self.activationDatePickerStrB isEqualToString:@""]||self.activationDatePickerStrB == nil) {
                NSDate * date = [NSDate date];
                NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
                dateForma.dateFormat = @"yyyy-MM-dd";
                NSString * dateStr = [dateForma stringFromDate:date];
                [self.activationEndTF setFont:[UIFont systemFontOfSize:14]];
                self.activationEndTF.text = dateStr;
                self.activationDatePickerStrB = dateStr;
            }else{
                self.activationEndTF.text = self.activationDatePickerStrB;
            }
            
        }
        [self.activationEndTF resignFirstResponder];
    }
    
    [self changeBtn];
}


#pragma mark ---- 按钮显示逻辑 ----
- (void)changeBtn
{
    self.selectedCount ++;
    if (self.selectedCount >1) {
        if (self.clcikDateSelected) {
            self.clcikDateSelected(YES);
        }
    }
}
#pragma mark ---- 优化边框
-(void)solveBorderWithView:(UIView *)view
{
    view.layer.borderColor = [RGB(149, 149, 149) CGColor];
    view.layer.borderWidth = 0.5f;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius  = 5.0f;
}
#pragma mark ---- 机器品牌 ----
- (IBAction)brandClick:(id)sender {
    NSString *titleStr = @"请选择";
//    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"不限",@"新国都",@"华智慧",@"新大陆", nil];
    SheetPickerView *pickerView = [SheetPickerView SheetStringPickerWithTitle:self.posBrandNameArr andHeadTitle:titleStr withIsDatePicker:NO Andcall:^(SheetPickerView *pickerView, NSString *choiceString) {
        [pickerView dismissPicker];
        if (self.brandBlock) {
            self.brandBlock(choiceString);
        }
    }];
    [pickerView show];
}
#pragma mark ---- 机器类型 ----
- (IBAction)typeClick:(id)sender {
    NSString *titleStr = @"请选择";
//    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"不限",@"G3",@"K320",@"K379", nil];
    SheetPickerView *pickerView = [SheetPickerView SheetStringPickerWithTitle:self.posTermTypeNameArr andHeadTitle:titleStr withIsDatePicker:NO Andcall:^(SheetPickerView *pickerView, NSString *choiceString) {
        [pickerView dismissPicker];
        if (self.typeBlock) {
            self.typeBlock(choiceString);
        }
    }];
    [pickerView show];
}
#pragma mark ---- 机器型号 ----
- (IBAction)modelClick:(id)sender {
    NSString *titleStr = @"请选择";
//    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"不限",@"M1",@"M2",@"M3", nil];
    SheetPickerView *pickerView = [SheetPickerView SheetStringPickerWithTitle:self.posTermModelNameArr andHeadTitle:titleStr withIsDatePicker:NO Andcall:^(SheetPickerView *pickerView, NSString *choiceString) {
        [pickerView dismissPicker];
        if (self.modelBlock) {
            self.modelBlock(choiceString);
        }
    }];
    [pickerView show];

}
#pragma mark ---- 是否激活 ----
- (IBAction)isActivationClick:(id)sender {
    NSString *titleStr = @"请选择";
    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"不限",@"是",@"否", nil];
    SheetPickerView *pickerView = [SheetPickerView SheetStringPickerWithTitle:nameArray andHeadTitle:titleStr withIsDatePicker:NO Andcall:^(SheetPickerView *pickerView, NSString *choiceString) {
        [pickerView dismissPicker];
        if (self.isActivationBlock) {
            self.isActivationBlock(choiceString);
        }
    }];
    [pickerView show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
