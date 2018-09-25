//
//  SLOrdersDeteiledLabel.m
//  Shopping
//
//  Created by chenpeng on 16/5/9.
//  Copyright © 2016年 鸿惠(上海)信息技术服务有限公司. All rights reserved.
//

#import "SLOrdersDeteiledLabel.h"

@interface SLOrdersDeteiledLabel ()



@end

@implementation SLOrdersDeteiledLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titltLabel = [[UILabel alloc] init];
        titltLabel.font = F12;
        titltLabel.textColor = C000000;
        [self addSubview:titltLabel];
        [titltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(AD_HEIGHT(15));
            make.centerY.offset(0);
        }];
        self.titleLabel = titltLabel;
        
        UILabel *textStrLabel = [[UILabel alloc] init];
        textStrLabel.font = F12;
        textStrLabel.textColor = C000000;
        [self addSubview:textStrLabel];
        [textStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-AD_HEIGHT(16));
            make.centerY.offset(0);
        }];
        self.textStrLabel = textStrLabel;
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{

    _title = title;
    self.titleLabel.text = title;
    


}

-(void)setTextStr:(NSString *)textStr{

    _textStr = textStr;
    self.textStrLabel.text = textStr;
    

}

- (void)setTitleStrColor:(UIColor *)titleStrColor
{
    _titleStrColor = titleStrColor;
    self.textStrLabel.textColor = titleStrColor;
}
@end
