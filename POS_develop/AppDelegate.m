//
//  AppDelegate.m
//  POS_develop
//
//  Created by sunyn on 2018/9/11.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AppDelegate.h"
#import "CFTabBarViewController.h"
#import "ConfigurationItem.h"
#import "RootViewController.h"
@interface AppDelegate (){
    RootViewController *mainViewController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [TBCityIconFont setFontName:@"icomoon"];
    
    [self setStatusBarBackgroundColor:RGB(45, 50, 60)];
    
    mainViewController=[[RootViewController alloc]init];
    mainViewController.view.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController = mainViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setNaviBack];//设置全局返回按钮
    
    //  统一设置导航栏
    //    [ConfigurationItem initializeInfomation];
    
    
    if (![USER_DEFAULT boolForKey:CF_DeleteOldAccountAndPwd]) {
        // 删除以前应用保存的用户名和密码
        [MyKeyChainHelper deletePasswordWithAccount:ACCOUNT];
        [MyKeyChainHelper deletePasswordWithAccount:PASSWORD];
        
        [USER_DEFAULT setBool:YES forKey:CF_DeleteOldAccountAndPwd];
        [USER_DEFAULT synchronize];
    }
    
    if(ScreenHeight > 480){
        _autoSizeScaleX = ScreenWidth/320;
        _autoSizeScaleY = ScreenHeight/568;
    }else{
        _autoSizeScaleX = 1.0;
        _autoSizeScaleY = 1.0;
    }
    
    //判断是否自动登录
    if([USER_DEFAULT objectForKey:CF_LastUserDic] != nil){
        FMLog(@"LastUserDic = %@",[USER_DEFAULT objectForKey:CF_LastUserDic]);
//        [self userLogin:[USER_DEFAULT objectForKey:CF_LastUserDic]];
    }
    return YES;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

//设置全局返回按钮
- (void)setNaviBack{
    
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    //返回按钮的箭头颜色
    //[navigationBar setTintColor:[UIColor colorWithRed:0.984 green:0.000 blue:0.235 alpha:1.000]];
    //设置返回样式图片
    UIImage *image;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) { // iOS系统版本 >= 11.0
        image = [UIImage imageNamed:@"back"];
    } else{ //iOS系统版本 < 11.0
        image = [UIImage imageNamed:@"图层55拷贝"];
    }
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    
    navigationBar.backIndicatorTransitionMaskImage = image;
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    
    UIOffset offset;
    
    offset.horizontal = - 500;
    offset.vertical =  - 500;
    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

//storyBoard view自动适配
+ (void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = CGRectMake(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = CGRectMake(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
            //            for (UIView *temp2 in temp1.subviews) {
            //                temp2.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
            //            }
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
