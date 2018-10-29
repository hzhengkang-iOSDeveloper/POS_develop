//
//  POS_ShopDetailViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/11.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"
@class POS_RootViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface POS_ShopDetailViewController : BaseSonViewController
@property (nonatomic, copy) NSString *posDetailStr;
@property (nonatomic, strong) POS_RootViewModel *model;
@end

NS_ASSUME_NONNULL_END
