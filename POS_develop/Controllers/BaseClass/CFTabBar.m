//
//  CFTabBar.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/11.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "CFTabBar.h"

@interface CFTabBar()
@property (nonatomic,weak)UIButton *plusButton;

@end
@implementation CFTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barStyle = UIBarStyleDefault;
        
        self.barTintColor = [UIColor whiteColor];
        self.translucent = NO;
        self.tintColor = [UIColor whiteColor];
        
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置plusButton的frame
    [self setupPlusButtonFrame];
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}


- (void)setupPlusButtonFrame{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.frame.size.width / (self.items.count);
    CGFloat buttonH;
    if (iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max){
        buttonH = self.frame.size.height - 5 - 34;
    }else {
        buttonH = self.frame.size.height - 5;
    }
    CGFloat ws = TabbarHeight_Before;
    FMLog(@"%f",ws);
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    tabBarButton.x = buttonW * index;
    
    tabBarButton.y = 2.5;
    
    
    for (UIBarButtonItem *item in self.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIColor blackColor], NSForegroundColorAttributeName,
                                      [UIFont systemFontOfSize:AD_HEIGHT(12)], NSFontAttributeName,
                                      nil] forState:normal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      RGB(31, 118, 225), NSForegroundColorAttributeName,
                                      [UIFont systemFontOfSize:AD_HEIGHT(12)], NSFontAttributeName,
                                      nil] forState:UIControlStateSelected];
    }
}



@end
