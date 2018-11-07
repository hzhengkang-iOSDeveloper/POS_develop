//
//  POS_CommitBillViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/12.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface POS_CommitBillViewController : BaseSonViewController
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) void (^updateData)(void);
@end

NS_ASSUME_NONNULL_END
