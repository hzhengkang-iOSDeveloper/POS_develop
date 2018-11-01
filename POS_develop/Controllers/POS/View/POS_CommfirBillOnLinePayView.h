//
//  POS_CommfirBillOnLinePayView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/12.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface POS_CommfirBillOnLinePayView : UIView
@property (nonatomic, copy) void (^payHandler)(NSUInteger payType);//0 微信  1支付宝
@property (nonatomic, copy) NSString *totalStr;
@end

NS_ASSUME_NONNULL_END
