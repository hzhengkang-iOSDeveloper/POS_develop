//
//  UILabel+Style.h
//  SuperWallet_Personal
//
//  Created by 孙亚男 on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface UILabel (Style)

//根据文字来定义label的高度
+ (CGFloat)heightWithText:(NSString *)text fontSize:(NSInteger)fontSize labelWidth:(CGFloat)labelWidth;

//修改label内字体大小
- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange;

//修改label内字体文字颜色
- (void)setText:(NSString *)text
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange;

//修改label内字体大小及文字颜色
- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange;

//修改2段文字及颜色
- (void)setText:(NSString *)text
      textFont1:(UIFont *)textFont1
     textcolor1:(UIColor *)color1
      textFont2:(UIFont *)textFont2
     textcolor2:(UIColor *)color2
         Range1:(NSRange)range1
         Range2:(NSRange)range2;

//修改label内字体文字颜色并加下划线
- (void)setUnderText:(NSString *)text
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange;
/**
 * masonry自适应高度
 */
- (void)changeLabelHeightWithWidth:(CGFloat)witdh;

/**
 label布局masonry
 */
+(UILabel *)getLabelWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
                   superView:(UIView *)superView
                  masonrySet:(void (^)(UILabel *view,MASConstraintMaker *make))block;
@end
