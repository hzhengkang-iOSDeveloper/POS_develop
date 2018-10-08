//
//  SheetPickerView.h
//  inspection
//
//  Created by fengjie on 16/9/7.
//  Copyright © 2016年 fengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SheetPickerView;
//回调  pickerView 回传类本身 用来做调用 销毁动作
//     choiceString  回传选择器 选择的单个条目字符串
typedef void(^SheetPickerViewBlock)(SheetPickerView *pickerView,NSString *choiceString);


@interface SheetPickerView : UIView

@property (nonatomic,copy)SheetPickerViewBlock callBack;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic,assign)BOOL isDatePicker;

//------单条选择器
+(instancetype)SheetStringPickerWithTitle:(NSMutableArray *)title andHeadTitle:(NSString *)headTitle  withIsDatePicker:(BOOL)isDatePicker Andcall:(SheetPickerViewBlock)callBack;
//显示
-(void)show;
//销毁类
-(void)dismissPicker;



@end
