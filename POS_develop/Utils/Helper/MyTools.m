//
//  MyTools.m
//  testJson
//
//  Created by gorson on 3/10/15.
//  Copyright (c) 2015 gorson. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools

/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentTimestamp
{
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    // 转为字符型
    return timeString;
}
+ (NSString *)getCurrentDay{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

/**
 *  获取当前标准时间（例子：2015-02-03）
 *
 *  @return 标准时间字符串型
 */
+ (NSString *)getCurrentStandarTime
{
    NSDate *  senddate=[NSDate date];

    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];

    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

/**
 *  时间戳转换为时间的方法
 *
 *  @param timestamp 时间戳
 *
 *  @return 标准时间字符串
 */
+ (NSString *)timestampChangesStandarTime:(NSString *)timestamp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;

}
+(NSString *)timeToweek:(NSString *)time{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *formatterDate = [inputFormatter dateFromString:time];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"HH:mm 'on' EEEE MMMM d"];
    // For US English, the output is:
    // newDateString 10:30 on Sunday July 11
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    return newDateString;
}
/**
 删除线
 */
+ (NSAttributedString *)deleteTextString:(NSString *)string
{
    NSInteger length = [string length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 设置attri的文本的一些属性
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    
    // 设置attri的文字颜色
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, length)];
    
    return attri;
}
//文字适配
+ (CGFloat)ratioWithNum:(CGFloat)num
{
    return num/(320*1.0)*[UIScreen mainScreen].bounds.size.width;
}

+ (void)ratioFontSize:(UIView *)view
{
    if([view isKindOfClass:[UILabel class]])
    {
        UILabel *lab=(UILabel *)view;
        CGFloat newFontSize=[MyTools ratioWithNum:lab.font.pointSize];
        lab.font=[UIFont systemFontOfSize:newFontSize];
    }
    
    if([view isKindOfClass:[UITextField class]])
    {
        UITextField *textField=(UITextField *)view;
        CGFloat newFontSize=[MyTools ratioWithNum:textField.font.pointSize];
        textField.font=[UIFont systemFontOfSize:newFontSize];
    }
    
    if([view isKindOfClass:[UIButton class]])
    {
        UIButton *btn=(UIButton *)view;
        CGFloat newFontSize=[MyTools ratioWithNum:btn.titleLabel.font.pointSize];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:newFontSize]];
    }
    
}
@end
