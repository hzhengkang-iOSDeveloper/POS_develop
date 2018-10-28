//
//  SettingWithdrawPsViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingWithdrawPsViewController : BaseSonViewController
@property (nonatomic, copy) NSString *withDrawPasswdID;
@property (nonatomic, copy) void(^popBlock)(void);
@end

NS_ASSUME_NONNULL_END
