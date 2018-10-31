//
//  MyAddressViewController.h
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"
@class MyAddressViewModel;
@interface MyAddressViewController : BaseSonViewController
@property (nonatomic, assign) BOOL isSelecteAddress;
@property (nonatomic, copy) void (^selectAddressHandler)(MyAddressViewModel *addressM);
@end
