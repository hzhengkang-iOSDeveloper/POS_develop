//
//  PD_BillDetailOnLineView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailOnLineView : UIView
//合计金额
@property (nonatomic, copy) NSString *heJiMoneyStr;
@property (nonatomic, copy) void (^payHandler)(NSUInteger payType,NSDictionary *dict);//0 微信  1支付宝 2线下支付
@end

NS_ASSUME_NONNULL_END
