//
//  UILabel+Style.m
//  SuperWallet_Personal
//
//  Created by 孙亚男 on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UILabel+Style.h"

@implementation UILabel (Style)

+ (CGFloat)heightWithText:(NSString *)text fontSize:(NSInteger)fontSize labelWidth:(CGFloat)labelWidth {
    
    if ([text isEqualToString:@""]) {
        return 0;
    }
    // 设置一个字典 保存文本属性
    // 保存文本字体大小 和label设置大小保持一致
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    // 预设一个尺寸大小 文本最大不超过 这个尺寸
    CGSize size = CGSizeMake(labelWidth, MAXFLOAT);
    // 根据文本内容获得一个CGRect
    
    // 参数1: 尺寸范围
    // 参数2: 按照什么方式获取rect
    // 参数3: 文本属性
    // 参数4: nil
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    // 返回得到高度
    return rect.size.height;
}

- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
{
    if (text.length == 0) {
        return;
    }
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSFontAttributeName value:textFont range:fontRange];
    [self setAttributedText:muStr];
}

- (void)setText:(NSString *)text
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange
{
    if (text.length == 0) {
        return;
    }
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    
    [self setAttributedText:muStr];
}

- (void)setUnderText:(NSString *)text
           textcolor:(UIColor *)color
          colorRange:(NSRange)colorRange
{
    if (text.length == 0) {
        return;
    }
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    [muStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:colorRange];
    [self setAttributedText:muStr];
}

- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange
{
    if (text.length == 0) {
        return;
    }
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSFontAttributeName value:textFont range:fontRange];
    [muStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    
    [self setAttributedText:muStr];
}

- (void)setText:(NSString *)text
      textFont1:(UIFont *)textFont1
     textcolor1:(UIColor *)color1
      textFont2:(UIFont *)textFont2
     textcolor2:(UIColor *)color2
         Range1:(NSRange)range1
         Range2:(NSRange)range2
{
    if (text.length == 0) {
        return;
    }
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSFontAttributeName value:textFont1 range:range1];
    [muStr addAttribute:NSFontAttributeName value:textFont2 range:range2];
    
    [muStr addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    [muStr addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    
    [self setAttributedText:muStr];
}

//自适应高度
- (void)changeLabelHeightWithWidth:(CGFloat)witdh
{
    self.preferredMaxLayoutWidth = witdh;
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

+(UILabel *)getLabelWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
                   superView:(UIView *)superView
                  masonrySet:(void (^)(UILabel *view,MASConstraintMaker *make))block
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(label,make);
        }
    }];
    return label;
}

@end
