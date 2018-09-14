//
//  ConfigurationItem.m
//  FortunesunMIS2.0
//
//  Created by 孙亚男 on 2017/4/12.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "ConfigurationItem.h"
#import "IQKeyboardManager.h"
#import "CustomImage.h"

@implementation ConfigurationItem
+ (void)initializeInfomation
{
   
    /*
     ** 统一配置导航栏字体颜色和背景颜色
     */
    UIFont *font = [UIFont systemFontOfSize:FITiPhone6(32)];
    
    NSDictionary *textAttributes = @{
                                     
                                     NSFontAttributeName : font,
                                     
                                     NSForegroundColorAttributeName : C090909
                                     
                                     };
   
        [[UINavigationBar appearance] setBackgroundImage:[CustomImage imageWithColor:WhiteColor size:CGSizeMake([[UIScreen mainScreen] currentMode].size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];

    
    

    /**
     *  status Bar
     */
     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
  
    /**
     *  统一导航条系统返回按钮图片，并通过偏移隐藏标题
     */
//    UIImage *backImage = [[[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,ShallowTextColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
    /**
     *  Navigation Title Color
     */
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName,nil]];
//    [[UINavigationBar appearance]  setTintColor:[UIColor redColor]];

//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,ShallowTextColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    [UINavigationBar appearance].backIndicatorImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,ShallowTextColor)];
    
    /**
     *  键盘管理
     */
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:6.f];

}



@end
