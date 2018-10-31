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
#import "LoginTypeViewController.h"
@interface RootViewController ()
{
    CFTabBarViewController *_tabbar;//主页面
    DirectivePageViewController *_directivePageVC;//引导页

}
@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeChildVc];
//    [self initOption];
}


#pragma mark 基本设置
- (void)basicSet
{
    //判断是否进入引导页
    if (![USER_DEFAULT boolForKey:CF_FirstOpenApp]) {
        _directivePageVC = [[DirectivePageViewController alloc] init];
        MJWeakSelf;
        _directivePageVC.endCallback = ^{
            
            [weakSelf changeChildVc];
        };
        [self addChildViewController:_directivePageVC];
    }else {
        [self changeChildVc];
    }

   
}

#pragma mark ---- 设置tabber ----
- (void)changeChildVc
{
    _tabbar = [[CFTabBarViewController alloc] init];
    _tabbar.root = self;
    [self addChildViewController:_tabbar];
    [self.view addSubview:_tabbar.view];
}
#pragma mark  基本信息初始化
- (void)initOption
{

    

    if (![USER_DEFAULT boolForKey:CF_FirstOpenApp]) {
        [self.view addSubview:_directivePageVC.view];
    }
    else {
        if (![[LoginManager getInstance] wasLogin]) {
            LoginTypeViewController *vc = [[LoginTypeViewController alloc] init];
            [self.view addSubview:vc.view];
        }else {
            [self.view addSubview:_tabbar.view];
        }
        
    }
}


#pragma mark 引导页调用
- (void)showTabbarViewControllerFromCG
{
    
    if (![[LoginManager getInstance] wasLogin]) {
        LoginTypeViewController *vc = [[LoginTypeViewController alloc] init];
        [self.view addSubview:vc.view];
    }else {
        [self.view addSubview:_tabbar.view];
    }
    
    
//    [self.view addSubview:_tabbar.view];
//    [self transitionFromViewController:_directivePageVC toViewController:_tabbar duration:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
//
//    } completion:^(BOOL finished) {
//        [_directivePageVC removeFromParentViewController];
//    }];
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
