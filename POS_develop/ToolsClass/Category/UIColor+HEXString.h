//
//  UIColor+HEXString.h
//  ByecityVisaAssistant
//
//  Created by byecity-yangfan on 14-3-7.
//  Copyright (c) 2014年 byecity. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 渐变方式
 
 - IHGradientChangeDirectionLevel:              水平渐变
 - IHGradientChangeDirectionVertical:           竖直渐变
 - IHGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - IHGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, IHGradientChangeDirection) {
    IHGradientChangeDirectionLevel,
    IHGradientChangeDirectionVertical,
    IHGradientChangeDirectionUpwardDiagonalLine,
    IHGradientChangeDirectionDownDiagonalLine,
};
@interface UIColor (HEXString)
+ (UIColor *) colorWithHexString: (NSString *)color;
/**
 创建渐变颜色
 
 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色
 
 @return 创建的渐变颜色
 */
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(IHGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;
@end
