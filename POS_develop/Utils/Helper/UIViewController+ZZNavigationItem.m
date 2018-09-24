//
//  UIViewController+ZZNavigationItem.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "UIViewController+ZZNavigationItem.h"
#import <objc/runtime.h>
#import "NSString+Helper.h"
#import "ZZActionButton.h"

@implementation UIViewController (ZZNavigationItem)

- (UIBarButtonItem *)addStandardBackButtonWithClickHandler:(ZZActionButtonClickBlockType)handler {
    return [self addBackButtonWithImage:[[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,C989898)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] clickHandler:handler];
}

- (UIBarButtonItem *)addBackButtonWithImage:(UIImage *)image clickHandler:(ZZActionButtonClickBlockType)handler {
    ZZActionButton *button = [ZZActionButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    
    if (!(IOS6)) {
        button.frame = CGRectMake(0, 0, FITiPhone6(20), FITiPhone6(17));
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -FITiPhone6(16), 0, 0);
    } else {
        button.frame = CGRectMake(0, 0, 65, 45);
    }
    
    if (handler == nil) {
        void (^backHandler)() = ^() {
            [self.navigationController popViewControllerAnimated:YES];
        };
        handler = backHandler;
    }
    button.clickHandler = handler;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    // http://blog.sina.com.cn/s/blog_8c87ba3b0102vgo5.html
    // self之前加上(id)仅仅是为了不让编译器报警告，别无他用
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    return backItem;
}

- (UIBarButtonItem *)addStandardBackButtonWithClickSelector:(SEL)selector {
    __weak typeof(self) weakself = self;
    // NSStringFromSelector(selector);
    
    return [self addStandardBackButtonWithClickHandler:^(){
        if ([weakself respondsToSelector:selector]) {
            
// http://www.07net01.com/program/548732.html
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSString *methodName = NSStringFromSelector(selector);
            if ([methodName containsString:@":"]) {
                [weakself performSelector:selector withObject:nil];
                // [weakself performSelectorInBackground:selector withObject:weakself.navigationItem.leftBarButtonItem];
            } else {
                [weakself performSelector:selector];
            }
#pragma clang diagnostic pop
        }
    }];
}

- (ZZActionButton *)addStandardRightButtonWithTitle:(NSString *)title clickHandler:(ZZActionButtonClickBlockType)handler {
    ZZActionButton *button = [ZZActionButton actionButtonWithType:UIButtonTypeCustom frame:CGRectMake(0, 0, 44, 44) title:title image:nil clickHandler:handler];
    // 考虑title过长的情况，让button的宽等于title所占的宽
    if (button.intrinsicContentSize.width > 45) {
        CGRect frame     = button.frame;
        frame.size.width = button.intrinsicContentSize.width;
        button.frame     = frame;
    }
    button.titleEdgeInsets     = UIEdgeInsetsMake(0, 15, 0, -10);
//    button.titleLabel.font     = LK_FONT_SIZE_TWO;
    button.clickHandler        = handler;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
//    [button setTitleColor:LD_COLOR_TEN forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return button;
}

- (ZZActionButton *)addStandardRightButtonWithTitle:(NSString *)title selector:(SEL)selector {
    __weak typeof(self) weakself = self;
    return [self addStandardRightButtonWithTitle:title clickHandler:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName containsString:@":"]) {
            // [weakself performSelector:selector withObject:nil];
            [weakself performSelector:selector withObject:weakself.navigationItem.rightBarButtonItem.customView];
        } else {
            [weakself performSelector:selector];
        }
#pragma clang diagnostic pop
    }];
}

- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)image clickHandler:(ZZActionButtonClickBlockType)handler {
    ZZActionButton *button = [ZZActionButton buttonWithType:UIButtonTypeCustom];
    [button setClickHandler:handler];
    button.frame = CGRectMake(0, 0, FITiPhone6(20), FITiPhone6(17));
    [button setImage:image forState:UIControlStateNormal];
    if (!(IOS6)) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

@end





