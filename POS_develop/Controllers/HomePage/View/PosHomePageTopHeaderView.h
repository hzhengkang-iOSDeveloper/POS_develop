//
//  PosHomePageTopHeaderView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/11/2.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosHomePageTopHeaderView : UIView
@property (nonatomic, strong) UILabel *volumeOfTransactionL;
@property (nonatomic, strong) UILabel *shareProfitL;
@property (nonatomic, strong) UILabel *activationL;
@property (nonatomic, strong) UILabel *teamPersonL;

@property (nonatomic, copy) void (^currentMonthBlock)(void);//当月交易量和当月分润点击

@end

NS_ASSUME_NONNULL_END
