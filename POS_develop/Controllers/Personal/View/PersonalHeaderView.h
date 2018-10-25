//
//  PersonalHeaderView.h
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHeaderView : UIView
@property (nonatomic, copy) void (^loginBlock)(void);
@property (nonatomic, copy) void (^withdrawBlock)(void);
@property (nonatomic, strong) UILabel *balanceL;
@property (nonatomic, strong) UILabel *yesterdayEarningsMoney;

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *invitedCodeLabel;
@property (nonatomic, strong) UIButton *userName;//登录注册按钮
@end
