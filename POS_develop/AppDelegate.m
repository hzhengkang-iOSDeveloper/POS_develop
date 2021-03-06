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
#import "LoginTypeViewController.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
#import "LoginTypeViewController.h"
#import "DirectivePageViewController.h"
#import "PosHomePageViewController.h"

@interface AppDelegate () <JPUSHRegisterDelegate>{
    RootViewController *mainViewController;
    CFTabBarViewController *_tabbar;//主页面
    DirectivePageViewController *_directivePageVC;//引导页
    LoginTypeViewController *_loginTypeVc;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MJWeakSelf;
    //清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    
   
    //开启推送
    [self setUpJPushSDKWith:launchOptions];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [TBCityIconFont setFontName:@"icomoon"];
    
    [self setStatusBarBackgroundColor:RGB(45, 50, 60)];
    
    if (![USER_DEFAULT boolForKey:CF_FirstOpenApp]) {
        _directivePageVC = [[DirectivePageViewController alloc] init];
        MJWeakSelf;
        _directivePageVC.endCallback = ^{
            [weakSelf confirLoginVc];
        };
        self.window.rootViewController = _directivePageVC;
        
    }else {
        if (![[LoginManager getInstance] wasLogin]) {
            [self confirLoginVc];
        }else {
            mainViewController=[[RootViewController alloc]init];
            mainViewController.view.backgroundColor=[UIColor whiteColor];
            self.window.rootViewController = mainViewController;
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }
    }
    
    
    
  
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
    if([USER_DEFAULT objectForKey:UserDict] != nil){
        FMLog(@"LastUserDic = %@",[USER_DEFAULT objectForKey:UserDict]);
//        [self userLogin:[USER_DEFAULT objectForKey:CF_LastUserDic]];
    }
    
    
    //注册appid
    [OpenShare connectWeixinWithAppId:WXAppID];
    [OpenShare connectAlipay];

    
    //环信注册
    HDOptions *option = [[HDOptions alloc] init];
    option.appkey = HD_APPKEY; // 必填项，appkey获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“AppKey”
    option.tenantId = HD_TENANTID;// 必填项，tenantId获取地址：kefu.easemob.com，“管理员模式 > 设置 > 企业信息”页面的“租户ID”
    //推送证书名字
//    option.apnsCertName = @"your apnsCerName";//(集成离线推送必填)
    //Kefu SDK 初始化,初始化失败后将不能使用Kefu SDK
    HDError *initError = [[HDClient sharedClient] initializeSDKWithOptions:option];
    if (initError) { // 初始化错误
    }
    
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapePattern:@"\\[[^\\[\\]]{1,3}\\]"];
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapeDictionary:[HDConvertToCommonEmoticonsHelper emotionsDictionary]];
    return YES;
}

#pragma mark ---- 设置登录控制器为root ----
- (void)confirLoginVc
{
    _loginTypeVc=[[LoginTypeViewController alloc]init];
    _loginTypeVc.view.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController = _loginTypeVc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
//和QQ,新浪并列回调句柄
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    
    return YES;
   
    
}


#pragma mark ------------  JPush
- (void)setUpJPushSDKWith:(NSDictionary *)launchOptions
{
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:advertisingId];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
    completionHandler();  // 系统要求执行这个方法
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    int badge =[userInfo[@"aps"][@"badge"] intValue];
    badge--;
    [JPUSHService setBadge:badge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // badge清零
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
