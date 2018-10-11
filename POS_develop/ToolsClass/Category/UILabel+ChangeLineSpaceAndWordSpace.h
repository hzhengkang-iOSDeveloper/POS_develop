//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  HpCF
//
//  Created by syn on 2017/11/13.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
/**
 * masonry自适应高度
 */
- (void)changeLabelHeightWithWidth:(CGFloat)witdh;
@end
