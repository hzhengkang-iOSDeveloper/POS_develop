//
//  HPDUtils.h
//  HePanDai
//
//  Created by HePanDai on 14-7-4.
//  Copyright (c) 2014 www.hepandai.com All rights reserved.
//

// As you know

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface HPDUtils : NSObject

@end

@interface NSString (HPDString)
/**
 *  wipe out commas from a string
 *
 *  @return a string with no commas
 */
- (NSString *)removeCommas;

/**
 *  check whether match the regex format
 *
 *  @param regex regex string
 *
 *  @return YES if match
 */
- (BOOL)checkMatchRegex:(NSString *)regex;

/**
 *  check a string whether match the monery format(two decimal places or no)
 *
 *  @return YES if a monery format
 */
- (BOOL)isMoneyFormmat;

/**
 *  check a string whether match the email format
 *
 *  @return YES if a email format
 */
- (BOOL)isEmailFormat;

/**
 *  check a string whether match the phone number format
 *
 *  @return YES if a phone number format
 */
- (BOOL)isPhoneNumberFormat;

/**
 *  check a string whether match the id card format
 *
 *  @return YES if a id card format
 */
- (BOOL)isIDCardFormart;

/**
 * check a string containt a substring
 *
 * @return YES Or No
 */
- (BOOL)containSubstring:(NSString*)substring;

- (NSString *)phoneNoCover;
- (NSString *)bankCardNoCover;
- (NSString *)bankCardFormat;

- (NSString *)append:(NSString *)otherStr;


/**
 transform string to integer value
 */
+ (NSString*)transformToInteger:(NSString*)string;


@end

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

/**
 *  md5 encripy use 16 bytes
 *
 *  @return the encripyed string
 */
-(NSString*)MD5With32Byte;

/**
 *  md5 encripy use 32 bytes
 *
 *  @return the encripyed string
 */
-(NSString*)MD5With16Byte;

@end


@interface NSDictionary(URLParams)

/**
 *  dictionary to url params format( param1=value1&param=value2 )
 *
 *  @discuss dictionary must only has NSString objects or NSNumber objects
 *
 *  @return string with url params format
 */
- (NSString *)urlParamsString;

@end

#ifdef __CORETEXT__

#import <CoreText/CoreText.h>

@interface NSAttributedString (Height)

/**
 *  calculate the height of a attribute string
 *
 *  @param inWidth the width of the string
 *
 *  @return the height of the string
 */
- (CGFloat)boundingHeightForWidth:(CGFloat)inWidth;

@end

#endif


@interface UIImage(Circle)

/**
 *  reshape the image to a circle shape
 *
 *  @param x      center.x
 *  @param y      center.y
 *  @param radius the circke radius
 *
 *  @return the new circle image
 */

- (UIImage *)circleMaskWithCenterX:(float)x centerY:(float)y radius:(float)radius;

@end

@interface UIImage (Scale)

/**
 *  resize the image
 *
 *  @param aSize new size
 *
 *  @return the new image with target size
 */
- (UIImage *)TransformtoSize:(CGSize)aSize;

@end

/**
 *  button with under line of title
 */
@interface UIHyperlinksButton : UIButton {
    UIColor *lineColor;
    BOOL isHighlight;
}
- (void)setColor:(UIColor*)color;
+ (UIHyperlinksButton *) hyperlinksButton;
@end


#ifndef _NSSTRING_HPDFORMAT_
#define _NSSTRING_HPDFORMAT_

@interface NSString(HPDFormat)

- (NSArray *)componentsSeparatedByFormatCharSet:(NSCharacterSet *)charset;

- (NSString *)resetStringWithFormat:(NSString *)format withCharSet:(NSCharacterSet *)charset;

- (NSString *)stringByRemovingCharacterSet:(NSCharacterSet *)charset;

@end

#endif

@interface NSDictionary(Keys)

- (BOOL)containsKey:(id)obj;

@end



@interface UIView(HPDDraw)


- (void)drawLineWithWidth:(CGFloat)lineWidth color:(UIColor *)lineColor formPoint:(CGPoint)point toPoint:(CGPoint)toPoint;


@end

@interface UILabel(HPDLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor/*default black color*/ backgroundColor:(UIColor *)backgroundColor/*default clear color*/;

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor/*default black color*/;

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment;

@end


@interface UIButton(HPDButton)


- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)text titleSize:(CGFloat)titleSize titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor;
@end


@interface NSDate(Interval)

+ (NSTimeInterval)intervalFromDate:(NSString *)fd toDate:(NSString *)td formaterString:(NSString *)format;

+ (NSTimeInterval)intervalFromDate:(NSString *)fd toDate:(NSString *)td formater:(NSDateFormatter *)format;

+ (NSString *)interval2String:(NSTimeInterval)interval;

@end

extern NSString * interval2String(NSTimeInterval interval);
extern NSTimeInterval interval(NSString *fd, NSString *td, NSString *fromat);
extern NSTimeInterval intervalWithFormat(NSString *fd, NSString *td, NSDateFormatter *fromat);

