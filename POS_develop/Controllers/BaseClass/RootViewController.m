//
//  RootViewController.m
//  HpCF
//
//  Created by 孙亚男 on 2017/11/3.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "RootViewController.h"
#import "CFTabBarViewController.h"
#import "DirectivePageViewController.h"
//#import "CF_GestureViewController.h"
@interface RootViewController ()
{
    CFTabBarViewController *_tabbar;//主页面
    DirectivePageViewController *_directivePageVC;//引导页
//    CF_GestureViewController *_gestureVC;
}
@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //程序进入后台 再次进入前台时间超过五分钟 接收通知展示手势密码
    [NOTIFICATION_CENTER addObserver:self selector:@selector(showGestureVC) name:@"cf_needShowGesture" object:nil];
    [self basicSet];
    [self initOption];
}
#pragma mark 接收通知展示手势页面
- (void)showGestureVC
{
    [USER_DEFAULT setBool:YES forKey:GestureViewAndApnsIsShow];//标示正在展示手势
//    if (_gestureVC.view) {
//        [_gestureVC.view removeFromSuperview];
//    }
//    _gestureVC = [[CF_GestureViewController alloc] initWithType:CFGesturePasswordTypeVerify];
//    _gestureVC.root = self;
//    [[UIApplication sharedApplication].keyWindow addSubview:_gestureVC.view];

}
#pragma mark 注销通知
- (void)dealloc
{
    [NOTIFICATION_CENTER removeObserver:self name:@"cf_needShowGesture" object:nil];
}

#pragma mark 基本设置
- (void)basicSet
{
    //判断是否进入引导页
    if (![USER_DEFAULT boolForKey:CF_FirstOpenApp]) {
        _directivePageVC = [[DirectivePageViewController alloc] init];
        MJWeakSelf;
        _directivePageVC.endCallback = ^{
            [weakSelf showTabbarViewControllerFromCG];
        };
        [self addChildViewController:_directivePageVC];
    }
    
//    BOOL isHaveGesturePwd = NO;//判断用户是否设置手势密码
//    NSMutableDictionary *gesturePwdDic = [USER_DEFAULT objectForKey:CF_GesturePwd];
//    if (gesturePwdDic == nil) {
//        isHaveGesturePwd = NO;//用户未设置手势密码
//    }else {
//        //用户已设置手势密码
//        NSString* lastUserName = [[USER_DEFAULT objectForKey:CF_LastUserDic] objectForKey:@"login_name"];
//        NSString* GestPwd = [gesturePwdDic objectForKey:lastUserName];
//        if (GestPwd.length<=0) {
//            isHaveGesturePwd = NO;
//        }else{
//            isHaveGesturePwd = YES;
//        }
//    }
//
//
//    if (isHaveGesturePwd) {
//        [USER_DEFAULT setBool:YES forKey:GestureViewAndApnsIsShow];//标示正在展示手势
//        _gestureVC = [[CF_GestureViewController alloc] initWithType:CFGesturePasswordTypeVerify];
//        _gestureVC.root = self;
//        [self addChildViewController:_gestureVC];
//    }else if([USER_DEFAULT objectForKey:CF_LastUserDic] != nil){
//        [USER_DEFAULT setBool:NO forKey:CF_GestureViewAndApnsIsShow];
//
//    }else{
//        [USER_DEFAULT setBool:NO forKey:CF_GestureViewAndApnsIsShow];
//        [USER_DEFAULT setIsLenit:NO];
//    }
    
    _tabbar = [[CFTabBarViewController alloc] init];
    _tabbar.root = self;
    [self addChildViewController:_tabbar];
}

#pragma mark  基本信息初始化
- (void)initOption
{
    BOOL isHaveGesturePwd = NO;
//    NSMutableDictionary* GesturePwdDic = [USER_DEFAULT objectForKey:CF_GesturePwd];
//    if (GesturePwdDic == nil) {
//        isHaveGesturePwd = NO;
//    }else{
        NSString* lastUserName = [[USER_DEFAULT objectForKey:CF_LastUserDic] objectForKey:@"login_name"];
//        NSString* GestPwd = [GesturePwdDic objectForKey:lastUserName];
//        if (GestPwd.length<=0) {
//            isHaveGesturePwd = NO;
//        }else{
//            isHaveGesturePwd = YES;
//        }
//    }
    
    if (![USER_DEFAULT boolForKey:CF_FirstOpenApp]) {
        [self.view addSubview:_directivePageVC.view];
    }
//    else if (isHaveGesturePwd && [USER_DEFAULT isLenit]) {
//        [self.view addSubview:_gestureVC.view];
//    }
    else {
        [self.view addSubview:_tabbar.view];
    }
}


#pragma mark 引导页调用
- (void)showTabbarViewControllerFromCG
{
    [self.view addSubview:_tabbar.view];
    [self transitionFromViewController:_directivePageVC toViewController:_tabbar duration:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
        
    } completion:^(BOOL finished) {
        [_directivePageVC removeFromParentViewController];
    }];
}

#pragma mark  手势密码界面调用
- (void)showTabbarViewControllerFromGesture:(BOOL)success
{
    //    [self.view addSubview:_tabbar.view];
//    if (!success) {
//        [NOTIFICATION_CENTER postNotificationName:UN_ShouldShowLoginViewController object:nil userInfo:nil];
//        //进入登陆模块
//        //        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    BOOL isSelfView =NO;
//    for (UIView *subView in self.view.subviews) {
//        if ([_gestureVC.view isEqual:subView]) {
//            isSelfView = YES;
//        }
//    }
//    if (isSelfView) {
//        [self transitionFromViewController:_gestureVC toViewController:_tabbar duration:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
//
//        } completion:^(BOOL finished) {
//            [_gestureVC removeFromParentViewController];
//        }];
//    }else {
//        [_gestureVC.view removeFromSuperview];
//    }
    
}
@end
