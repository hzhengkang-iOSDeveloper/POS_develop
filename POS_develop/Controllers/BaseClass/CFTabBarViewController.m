//
//  CFTabBarViewController.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/11.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "CFTabBarViewController.h"
#import "CFTabBar.h"
#import "PosHomePageViewController.h"
#import "POSViewController.h"
#import "GeneralizeViewController.h"
#import "PersonalViewController.h"

@interface CFTabBarViewController ()

@end

@implementation CFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVcs];
    
    [self addCustomTabBar];
    
    
}

- (void)addCustomTabBar{
    CFTabBar *customTabBar = [[CFTabBar alloc] init];
    //    customTabBar.delegate = self;
    customTabBar.barTintColor = [UIColor whiteColor];
    
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    
}

- (void)addAllChildVcs{
    PosHomePageViewController *homePageVC = [[PosHomePageViewController alloc] init];
    [self addOneChlildVc:homePageVC title:@"首页" imageName:[[ UIImage imageNamed:@"首页1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImageName:[[ UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    POSViewController *posVC = [[POSViewController alloc] init];
    [self addOneChlildVc:posVC title:@"POS" imageName:[[ UIImage imageNamed:@"pos机"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImageName:[[ UIImage imageNamed:@"pos机1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    GeneralizeViewController *generalizeVC = [[GeneralizeViewController alloc] init];
    [self addOneChlildVc:generalizeVC title:@"推广" imageName:[[ UIImage imageNamed:@"推广"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImageName:[[ UIImage imageNamed:@"推广1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    PersonalViewController *personalVC = [[PersonalViewController alloc] init];
    [self addOneChlildVc:personalVC title:@"我的" imageName:[[ UIImage imageNamed:@"我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImageName:[[ UIImage imageNamed:@"我的1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
}


#pragma mark  通知
- (void)showUserLoginViewController
{
//    [self setSelectedIndex:Account_Login_Index];
//    [NOTIFICATION_CENTER postNotificationName:UN_LoginOutTime object:nil];
    
}
#pragma mark 注销通知
- (void)dealloc
{
//    [NOTIFICATION_CENTER removeObserver:self name:UN_ShouldShowLoginViewController object:nil];
}
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(UIImage *)imageName selectedImageName:(UIImage *)selectedImageName
{
    //设置tabbarItem的title
    childVc.tabBarItem.title = title;
    // 设置图标
    UIImage *normaliamge = imageName;
    
    normaliamge = [normaliamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = normaliamge;
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    [textAttrs setObject:UIHexColor(0x464646) forKey:NSForegroundColorAttributeName];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    [selectedTextAttrs setValue:C1E95F9 forKey:NSForegroundColorAttributeName];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor redColor], NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor greenColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];
    // 设置选中的图标
    UIImage *selectedImage = selectedImageName;
    
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    
    
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    [self animationWithIndex:index];
//}
//- (void)animationWithIndex:(NSInteger) index {
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
//    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.08;
//    pulse.repeatCount= 1;
//    pulse.autoreverses= YES;
//    pulse.fromValue= [NSNumber numberWithFloat:0.7];
//    pulse.toValue= [NSNumber numberWithFloat:1.3];
//    [[tabbarbuttonArray[index] layer]
//     addAnimation:pulse forKey:nil];
//}

@end


