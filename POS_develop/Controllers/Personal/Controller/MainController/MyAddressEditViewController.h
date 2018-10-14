//
//  MyAddressEditViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/14.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyAddressEditViewController : BaseSonViewController
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *detailAdd;
@property (nonatomic, copy) NSString *isDefault;

@property (nonatomic, copy) void (^updateAddressList)(void);
@end

NS_ASSUME_NONNULL_END
