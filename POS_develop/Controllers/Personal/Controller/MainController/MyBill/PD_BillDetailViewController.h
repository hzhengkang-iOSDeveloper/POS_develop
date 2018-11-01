//
//  PD_BillDetailViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailViewController : BaseSonViewController
@property (nonatomic, copy) void (^updateDataHandler)(void);
@property (nonatomic, copy) NSString *myID;
@property (nonatomic, copy) NSString *orderStatu;
@end

NS_ASSUME_NONNULL_END
