//
//  PlaceholderTextView.m
//  XiaoMei
//
//  Created by PingTou on 15/11/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView ()





@end
@implementation PlaceholderTextView

//-(UILabel *)placeholderLabel
//{
//    if (!_placeholderLabel) {
//        UILabel *label = [[UILabel alloc]init];
//        label.font = [UIFont systemFontOfSize:14];
//        label.textColor = [UIColor grayColor];
//        label.numberOfLines = 0;
//        self.placeholderLabel = label;
//    }
//    return self.placeholderLabel;
//}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor= [UIColor clearColor];
        
        UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
        
        
        placeholderLabel.textColor = C000000;
        placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel= placeholderLabel; //赋值保存
        self.placeholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
        
        self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        
    }
    return self;
}

/**
 *  设置占位文字的显示
 */
-(void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x = 4;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    self.placeholderLabel.font = self.placeholderFont ? self.placeholderFont : [UIFont systemFontOfSize:15];
    [self.placeholderLabel sizeToFit];//这一步很重要，不能遗忘
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    self.placeholderLabel.height= [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;//此句的意义何在？
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    self.placeholderLabel.textColor = placeholderColor;
    [self setNeedsLayout];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
  
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
  
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
    
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    self.placeholderLabel.y=8; //设置UILabel 的 y值
//    
//    self.placeholderLabel.x=5;//设置 UILabel 的 x 值
//    
//    self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0; //设置 UILabel 的 x
//    
//    //根据文字计算高度
//    
//    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
//    
//    self.placeholderLabel.height= [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
//}
@end
