//
//  BaseSonViewController.m
//  ZNSuperWallet
//
//  Created by 孙亚男 on 2016/10/13.
//  Copyright © 2016年 孙亚男. All rights reserved.
//

#import "BaseSonViewController.h"
#import "CF_LeftNavigationBar_BackBtn.h"
@interface BaseSonViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseSonViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    self.navigationController.navigationBar.translucent = NO;
}

// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CF6F6F6;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
//    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"背景底色"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"背景底色"] forBarMetrics:UIBarMetricsDefault];
    /* 系统自带的侧滑返回 */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [NOTIFICATION_CENTER addObserver:self selector:@selector(userLoginOuttime) name:UN_LoginOutTime object:nil];

//    CF_LeftNavigationBar_BackBtn *firstButton = [CF_LeftNavigationBar_BackBtn buttonWithType:UIButtonTypeCustom];
//    firstButton.frame = CGRectMake1(-30, 0, FITiPhone6(100), FITiPhone6(100));
//    [firstButton setImage:[[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,DeepTextColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:normal];
//    [firstButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//
//    if (!iOS11) {
//        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
//
//        if ([UIScreen mainScreen].bounds.size.height <= 568.0) {
//            [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, FITiPhone6(50) *ScreenWidth /375.0,0,0)];
//        }else{
//            [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, FITiPhone6(35) *ScreenWidth /375.0,0,0)];
//        }
//    }
//
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
//
//    UIOffset offset;
//
//    offset.horizontal = -100;
//
//    offset.vertical =  - 100;
//
//    [leftBarButtonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];

    
    [self barLineSetting];
}
- (void)userLoginOuttime
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//内存释放
- (void)dealloc
{
    [NOTIFICATION_CENTER removeObserver:self name:UN_LoginOutTime object:nil];
}

- (void)barLineSetting{
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, ScreenWidth, FITiPhone6(0.5));
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   CE6E2E2.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.tabBarController.tabBar setShadowImage:img];
    
    [self.tabBarController.tabBar setBackgroundImage:[[UIImage alloc]init]];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)backClick{
    if (self.backHandler) {
        self.backHandler();
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)setBgimgName:(NSString *)bgimgName
{
    if (IS_STRING(bgimgName)) {
        _bgimgName = bgimgName;
        _img.image = [UIImage imageNamed:bgimgName];
    }
}

#pragma mark - 解决隐藏tabbar后底部视图button不响应问题
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)setNavigationItemTitle:(NSString *)navigationItemTitle
{
    _navigationItemTitle = navigationItemTitle;
    if (navigationItemTitle) {
        self.navigationItem.title = navigationItemTitle;
    }
}

@end

