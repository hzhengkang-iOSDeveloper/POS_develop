//
//  POSRootViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface POSRootViewController : BaseSonViewController
@property (nonatomic, copy) void (^changeShopCarCount)(NSUInteger addGoodCount);
@property (nonatomic, copy) NSString *podId;
@end

NS_ASSUME_NONNULL_END
