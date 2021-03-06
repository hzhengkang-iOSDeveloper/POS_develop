//
//  PD_BillDetailOutLineInfoView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailOutLineInfoView : UIView
@property (nonatomic, copy) void (^outLinePayHandler)(NSDictionary *dict);

//合计金额
@property (nonatomic, copy) NSString *heJiMoneyStr;
@end

NS_ASSUME_NONNULL_END
