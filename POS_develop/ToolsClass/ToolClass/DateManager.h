//
//  DateManager.h
//  NSDateManager
//
//  Created by 孙亚男 on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

///获取系统当前日期
+ (NSString *)systemYear;
+ (NSString *)systemMonth;
+ (NSString *)systemEnglishMonth;
+ (NSString *)systemDay;
+ (NSString *)systemDateWithCutString:(NSArray *)cutStrArr;

///获取系统时间戳
+ (NSString *)getSystemTimeString;
+ (NSString *)getSystemTimeString8Hours;

///年月日转时间戳
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSString *)getTimeStringWithYearMonthDay:(NSString *)yearMonthDay formatterType:(NSString *)type;


///date转时间戳
+ (NSString *)getTimeStringWithDate:(NSDate *)date;

///时间戳转datestr
+ (NSString *)getDateWithTimeString:(NSString *)timeStr;
+ (NSString *)timeStr:(NSString *)timeStr formatterType:(NSString *)type;

//data转时间戳
+ (NSString *)getDateStringWithDate:(NSDate *)date  formatterType:(NSString *)type;

///date用str输出
+ (NSString *)getDateStringWithDate:(NSDate *)date;

///传入时间戳和时间格式返回时间
+(NSString*)getDateStringWithString:(NSString*)timerStr Format:(NSString*)format;
+(NSString*)getDateStringWithString13:(NSString*)timerStr Format:(NSString*)format;
///获取系统时间精确到秒
+ (NSString *)getSystemTime;//非本时区
+ (NSString *)getSystemTimeWith8Hours;//本时区

///date转为本时区date
+ (NSDate *)getTootTimeZoneWithAnydate:(NSDate *)date;

///60秒倒计时方法
+ (void)getValidateCodeWithPerformer:(id)sender completion:(void (^)(NSString *strTime))starting completion:(void (^)(void))ending;

+ (NSString *)getSystemTimeMouth;

+ (NSString *)getSystemTimeZL_SuperJF;

//获取星期几，如果是今天就显示今天。 超过七天显示日期
+ (NSString *)getWeekDayForDateStr:(NSString *)dataStr;
//只获取星期几
+ (NSString *)getWeekDay:(NSString *)dataStr;

@end
