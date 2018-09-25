//
//  ActivationMoneyDetailHeaderView.h
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivationMoneyDetailHeaderView : UIView

@property (nonatomic, strong) UILabel *totalPenLabel;
@property (nonatomic, strong) UILabel *totalAmountLabel;

@property (nonatomic, copy) void (^searchBlock)(void);
@end

NS_ASSUME_NONNULL_END
