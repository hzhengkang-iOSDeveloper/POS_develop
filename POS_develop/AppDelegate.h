//
//  AppDelegate.h
//  POS_develop
//
//  Created by sunyn on 2018/9/11.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property float autoSizeScaleX;
@property float autoSizeScaleY;
@property (strong, nonatomic) UIWindow *window;
//兼容函数
+ (void)storyBoradAutoLay:(UIView *)allView;

@end

