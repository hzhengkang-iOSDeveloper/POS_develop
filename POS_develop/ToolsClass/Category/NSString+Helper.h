//
//  NSString+Helper.h
//  XmppDemos
//
//  Created by d2space on 14-11-11.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper) <UIActionSheetDelegate>
+(NSUInteger)textLength: (NSString *) text;
+(NSString *)productbackBase64stringFromDict:(NSString *)str;
/**
 *  新加密
 *
 */
+(NSString *)backBase64stringFromDict:(NSString *)str str:(NSString *)sourceType;
/**
 *  加密
 *
 *  @param bussiness 商户id
 *  @param key       key
 *
 *  @return 加密后的字符串
 */
- (NSString *)backcCipherBusskey:(NSString *)key;
/**
 *  元素排序
 *
 *  @param arr 传入的数组
 *
 *  @return 排序后的数组
 */
- (NSArray *)elementOrdering:(NSArray *)arr;
/**
 *  随机产生32位UUID;
 *
 *  @return <#return value description#>
 */
+ (NSString *)toUUIDString;
//沙盒文件路径
+ (NSString *)documentsPath:(NSString *)fileName;

//NSUserDefault 存值
- (void) saveToNSUserDefaultsWithKey:(NSString *)key;

//string去掉空格后，判断是否为空
-(BOOL)isBlank;

//判断string是否有效，去除为空或者是null类型
-(BOOL)isValid;

//清字符串两端的空白字符
- (NSString *)removeWhiteSpacesFromString;

//获取字符串中单词的个数，以空格为判断依据
- (NSUInteger)countNumberOfWords;

//字符串中是否包含指定字符串
- (BOOL)containsString:(NSString *)subString;

//字符串是否以指定字符串开头
- (BOOL)isBeginsWith:(NSString *)string;

//字符串是否以指定字符串结束
- (BOOL)isEndssWith:(NSString *)string;

//字符串替换
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;

//字符串中，从指定位置取到结束
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;

//字符串拼接
- (NSString *)addString:(NSString *)string;

//字符串删除指定字符串
- (NSString *)removeSubString:(NSString *)subString;

//字符串是否是纯字母
- (BOOL)containsOnlyLetters;

//字符串是否是纯数字
- (BOOL)containsOnlyNumbers;

//字符串是否是数字和小数点组成
- (BOOL)containsOnlyNumbersAndPoint;

//字符串是否含有汉字
- (BOOL)containsChinese;

//字符串是否为纯汉字
- (BOOL)isChinese;

//字符串是否是字母和数字
- (BOOL)containsOnlyNumbersAndLetters;

//数组中是否存在相同字符串
- (BOOL)isInThisarray:(NSArray*)array;

//数组以“ ”分隔，转换为字符串
+ (NSString *)getStringFromArray:(NSArray *)array;

//字符串以“ ” ，转换成数组
- (NSArray *)getArray;

//获取应用版本号
+ (NSString *)getMyApplicationVersion;

//获取应用名称
+ (NSString *)getMyApplicationName;

//字符串转换为nsdata
- (NSData *)convertToData;

//NSDATA转换为字符串
+ (NSString *)getStringFromData:(NSData *)data;

//字符串正则判断是否为email
- (BOOL)isValidEmail;

//字符串正则判断是否为手机号
- (BOOL)isVAlidPhoneNumber;

//密码输入是否合法
- (BOOL)isValidPassword;

//字符串正则判断是否为url
- (BOOL)isValidUrl;

/** 打电话 */
- (void)phoneCall;

/**
 *  字符串转日期，默认格式yyyy-MM-dd
 */
- (NSDate *)toDate;
- (NSDate *)toDateWithFormat:(NSString *)format;

// 是否符合正则 regex
- (BOOL)validateWithRegex:(NSString *)regex;

// 价格输入
- (BOOL)validPrice;
//md5加密
- (NSString *)mdd5;

//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
@end
