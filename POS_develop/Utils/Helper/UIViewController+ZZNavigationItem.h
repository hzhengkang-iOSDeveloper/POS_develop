//
//  UIViewController+ZZNavigationItem.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZActionButton.h"

#define ADD_STANDARD_BACK_NAV_BUTTON [self addStandardBackButtonWithClickHandler:nil] // 添加导航条返回按钮

@interface UIViewController (ZZNavigationItem)

/**
 *  由于项目中很多返回按钮都一样，在此提取出来 [标准的返回按钮，即只有一个向左的箭头]
 *
 *  @param handler 点击按钮回调
 *
 *  @return 添加的UIBarButtonItem对象
 */
- (UIBarButtonItem *)addStandardBackButtonWithClickHandler:(ZZActionButtonClickBlockType)handler;

- (UIBarButtonItem *)addBackButtonWithImage:(UIImage *)image clickHandler:(ZZActionButtonClickBlockType)handler;


/**
 *  由于项目中很多返回按钮都一样，但是点击这个返回按钮时原来的逻辑都写好，为了适配把selector传进来
 *
 *  @param selector 点击按钮回调
 *
 *  @return 添加的UIBarButtonItem对象
 */
- (UIBarButtonItem *)addStandardBackButtonWithClickSelector:(SEL)selector;

/**
 *  由于项目中很多控制器导航条右侧有按钮并且样式一样，在此提取出来
 *
 *  @param handler 点击按钮回调
 *
 *  @return 添加的button对象
 */
- (ZZActionButton *)addStandardRightButtonWithTitle:(NSString *)title clickHandler:(ZZActionButtonClickBlockType)handler;
- (ZZActionButton *)addStandardRightButtonWithTitle:(NSString *)title selector:(SEL)selector;
- (ZZActionButton *)addRightBarButtonWithImage:(UIImage *)image clickHandler:(ZZActionButtonClickBlockType)handler;

@end
