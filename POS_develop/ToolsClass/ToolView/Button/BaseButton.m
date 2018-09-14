//
//  BaseButton.m
//  TripCredit
//
//  Created by sunyanan on 2017/6/17.
//  Copyright © 2017年 sunyanan. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (instancetype)initFrameWith:(CGRect)frame  Title:(NSString *)title  Target:(nullable id)target action:(SEL)action
{
    return [[BaseButton alloc]initFrameWith:frame Title:title Target:target action:action];
}


+ (instancetype)initFrameWith:(CGRect)frame  Title:(NSString *)title  Target:(nullable id)target action:(SEL)action
{
    BaseButton *btn  =[BaseButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:TextColor_Gray];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:FITiPhone6(32)]];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = FITiPhone6(44);
    btn.layer.masksToBounds = YES;
    return btn;
}
@end
