//
//  UIView+SystemBackBar.m
//  HpCF
//
//  Created by syn on 2017/10/20.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "UIView+SystemBackBar.h"

@implementation UIView (SystemBackBar)
//+ (void)load
//{
//    if (@available(iOS 11, *)) {
//        [NSClassFromString(@"_UIBackButtonContainerView")     jr_swizzleMethod:@selector(addSubview:) withMethod:@selector(iOS11BackButtonNoTextTrick_addSubview:) error:nil];
//    }
//}
//- (void)iOS11BackButtonNoTextTrick_addSubview:(UIView *)view
//{
//    view.alpha = 0;
//    if ([view isKindOfClass:[UIButton class]]) {
//        UIButton *button = (id)view;
//        [button setTitle:@" " forState:UIControlStateNormal];
//    }
//    [self iOS11BackButtonNoTextTrick_addSubview:view];
//    
//}

@end
