//
//  CFTabBar.h
//  HpCF
//
//  Created by 孙亚男 on 2017/10/11.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFTabBar;
@protocol CFTabBarDelegate <NSObject>

@optional
//- (void)tabBarDidClickedPlusButton:(CFTabBar *)tabBar;

@end

@interface CFTabBar : UITabBar
//@property(nonatomic, weak) id<CFTabBarDelegate> delegate;
@end
