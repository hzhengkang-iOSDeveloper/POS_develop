//
//  DateManager.m
//  NSDateManager
//
//  Created by 孙亚男 on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager

#pragma mark - 获取系统当前日期
+ (NSString *)systemYear
{
    //获得系统时间年
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger yearNow = [conponent year];
    
    return [NSString stringWithFormat:@"%ld", (long)yearNow];
}


+ (NSString *)systemMonth
{
    //获得系统时间月
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger monthNow = [conponent month];
    
    return [NSString stringWithFormat:@"%ld", (long)monthNow];
}

+ (NSString *)systemEnglishMonth
{
    //获得系统时间月
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger monthNow = [conponent month];
    
    NSString *CNmonth = [NSString stringWithFormat:@"%02ld", (long)monthNow];
    NSString *ENmonth = @"";
    switch ([CNmonth integerValue]) {
        case 1:
            ENmonth = @"January.";
            break;
        case 2:
            ENmonth = @"February.";
            break;
        case 3:
            ENmonth = @"March.";
            break;
        case 4:
            ENmonth = @"April.";
            break;
        case 5:
            ENmonth = @"May.";
            break;
        case 6:
            ENmonth = @"June.";
            break;
        case 7:
            ENmonth = @"July.";
            break;
        case 8:
            ENmonth = @"August.";
            break;
        case 9:
            ENmonth = @"September.";
            break;
        case 10:
            ENmonth = @"October.";
            break;
        case 11:
            ENmonth = @"November.";
            break;
        case 12:
            ENmonth = @"December.";
            break;
        default:
            break;
    }
    
    return ENmonth;
}


+ (NSString *)systemDay
{
    //获得系统时间日
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger dayNow = [conponent day];
    
    return [NSString stringWithFormat:@"%ld", (long)dayNow];
}


+ (NSString *)systemDateWithCutString:(NSArray *)cutStrArr
{
    //获得系统时间日
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger dayNow = [conponent day];
    NSInteger monthNow = [conponent month];
    NSInteger yearNow = [conponent year];
    
    if (cutStrArr.count == 3) {
        return [NSString stringWithFormat:@"%ld%@%ld%@%ld%@", (long)yearNow, cutStrArr[0],(long)monthNow, cutStrArr[1], (long)dayNow, cutStrArr[2]];
    } else {
        return [NSString stringWithFormat:@"%ld%@%ld%@%ld%@", (long)yearNow, @"-",(long)monthNow, @"-", (long)dayNow, @"-"];
    }
}

+ (NSString *)getSystemTimeString
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

+ (NSString *)getSystemTimeString8Hours
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] + 3600 * 8;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}


+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    //转时间戳
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    //任何时间string转date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:dateString];
    //时间date转时间戳
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    //转时间戳
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld  %ld-%ld-%ld", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
    //任何时间string转date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-M-d  H-m-s"];
    NSDate *date=[dateFormatter dateFromString:dateString];
    //时间date转时间戳
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

+ (NSString *)getTimeStringWithYearMonthDay:(NSString *)yearMonthDay formatterType:(NSString *)type
{
    //任何时间string转date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:type];
    NSDate *date=[dateFormatter dateFromString:yearMonthDay];
    //时间date转时间戳
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

+ (NSString *)getTimeStringWithDate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", time];
}


+ (NSString *)getDateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date  formatterType:(NSString *)type
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:type];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

+ (NSString *)getDateWithTimeString:(NSString *)timeStr
{
    NSTimeInterval timer=[timeStr doubleValue];
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:timer];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=NSDateFormatterShortStyle;
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm"];
    NSString *str22=[formatter stringFromDate:date];
    
    
    return str22;
}

+ (NSString *)timeStr:(NSString *)timeStr formatterType:(NSString *)type
{
    if (!timeStr) {
        return @"";
    }
    NSTimeInterval timer=[timeStr doubleValue];
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:timer];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=NSDateFormatterShortStyle;
    [formatter setDateFormat:type];
    NSString *str22=[formatter stringFromDate:date];
    
    
    return str22;
}


+ (NSString *)getSystemTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}


+ (NSString *)getSystemTimeWith8Hours
{
    NSDate *  senddate=[NSDate date];
    
    NSTimeInterval time = [senddate timeIntervalSince1970] + 3600 * 8;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:confromTimesp];
    
    return morelocationString;
}

+ (NSDate *)getTootTimeZoneWithAnydate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970] + 3600 * 8;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    return confromTimesp;
}


+ (void)getValidateCodeWithPerformer:(id)sender completion:(void (^)(NSString *))starting completion:(void (^)(void))ending
{
    //倒计时
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        timeout--;
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置(倒计时结束)
                ending();
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"剩余%.2d秒", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置(倒计时中)
                starting(strTime);
                
            });
        }
    });
    dispatch_resume(_timer);
}



+(NSString*)getDateStringWithString:(NSString*)timerStr Format:(NSString*)format{
//yyyy-MM-dd  HH:mm:ss
    NSTimeInterval timer=[timerStr doubleValue];
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:timer];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=NSDateFormatterShortStyle;
    [formatter setDateFormat:format];
    NSString *str22=[formatter stringFromDate:date];
    return str22;
}
+(NSString*)getDateStringWithString13:(NSString*)timerStr Format:(NSString*)format{
    //yyyy-MM-dd  HH:mm:ss
    NSTimeInterval timer=[timerStr doubleValue] / 1000;
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:timer];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=NSDateFormatterShortStyle;
    [formatter setDateFormat:format];
    NSString *str22=[formatter stringFromDate:date];
    return str22;
}

+ (NSString *)getSystemTimeMouth
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}
+ (NSString *)getSystemTimeZL_SuperJF
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年  MM月"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}

//根据时间戳获取星期几
+ (NSString *)getWeekDayForDateStr:(NSString *)dataStr
{
    dataStr = [NSString stringWithFormat:@"%@", dataStr];
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSTimeInterval timer = [dataStr doubleValue];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timer];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    
    //用来返回今天
    NSTimeInterval timernow = [[NSDate date] timeIntervalSince1970];
    NSDate *newDate1 = [NSDate dateWithTimeIntervalSince1970:timernow];
    NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components1 = [calendar1 components:NSCalendarUnitWeekday fromDate:newDate1];
    NSString *weekStr1 = [weekday objectAtIndex:components1.weekday];
    
    if (timernow - timer >= 3600 * 6 * 24) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        [formatter setDateFormat:@"MM/dd"];
        return [formatter stringFromDate:newDate];
    }
    
    if ([weekStr isEqualToString:weekStr1]) {
        return @"今天";
    }
    
    return weekStr;
}


+ (NSString *)getWeekDay:(NSString *)dataStr
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    NSTimeInterval timer = [dataStr doubleValue];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timer];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    
    return weekStr;
}


@end
