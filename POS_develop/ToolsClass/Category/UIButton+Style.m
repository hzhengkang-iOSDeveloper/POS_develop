//
//  UIButton+Style.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)
+(UIButton *)getButtonWithImageName:(NSString *)imageName
                          titleText:(NSString *)titleStr
                          superView:(UIView *)superView
                         masonrySet:(void (^)(UIButton *btn,MASConstraintMaker *make))block{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:titleStr forState:normal];
    if (![imageName isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(btn,make);
        }
    }];
    return btn;
}
@end
