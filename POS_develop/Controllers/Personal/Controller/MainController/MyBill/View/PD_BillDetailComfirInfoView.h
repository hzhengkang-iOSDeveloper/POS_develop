//
//  PD_BillDetailComfirInfoView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailComfirInfoView : UIView
@property (nonatomic, copy) void (^comfirHandler)(void);
//确认收货
@property (nonatomic, weak) UIButton *comfirInfoBtn;
@end

NS_ASSUME_NONNULL_END
