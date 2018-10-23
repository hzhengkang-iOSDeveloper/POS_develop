//
//  DatePickerView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerView : UIView
@property (strong , nonatomic)UIDatePicker * FirstDatePicker;
@property (strong , nonatomic)UIDatePicker * SecondDatePicker;
@property (copy   , nonatomic)NSString     * datePickerStrA;//记录datePicker上日期
@property (copy   , nonatomic)NSString     * datePickerStrB;//记录datePicker上日期
@property (strong , nonatomic)UIToolbar * FirstToolBar;
@property (nonatomic, strong) UITextField *startTimeTF;
@property (nonatomic, strong) UITextField *endTimeTF;

@property (nonatomic, assign) BOOL agentOrPersonIsSelected;
@property (nonatomic, copy) void (^clcikDateSelected)(BOOL isSelected);
@property (nonatomic, copy) void (^backVcChangeBtn)(void);

@end

NS_ASSUME_NONNULL_END
