//
//  ProjectExtension.h
//  HePanDai2_0
//
//  Created by sands on 16/8/17.
//  Copyright © 2016年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ProjectExtension)

/**
 *  返回一个string对象
 *
 *  @return 
 */
- (NSString*)isStringValue;

@end

#pragma mark NSString扩展
@interface NSString (ProjectExtension)

/**
 *  转换成NSDate时间
 *
 *  @return NSDate
 */
- (NSDate*)ToNSDate;
/**
 *  转换成用于精确计算的DeciamlNumber
 *
 *  @return NSDecimalNumber
 */
- (NSDecimalNumber*)toDeciamlNumber;

/**
 *  计算字符串应占用的高度
 *
 *  @param font  字体
 *  @param size 字符串容器的宽度
 *
 *  @return 高度
 */
- (CGFloat)CalculateStringHeight:(UIFont*)font size:(CGSize)size;

@end

#pragma mark UIColor扩展

@interface UIColor (ProjectExtension)
/**
 *  传入hex颜色值 返回一个UIColor对象
 *
 *  @param color string类型的hex颜色值(如#123456)
 *  @param alpha 透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
