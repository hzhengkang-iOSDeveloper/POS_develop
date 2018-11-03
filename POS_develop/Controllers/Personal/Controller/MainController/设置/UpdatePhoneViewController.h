//
//  UpdatePhoneViewController.h
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

@interface UpdatePhoneViewController : BaseSonViewController
@property (nonatomic, copy) void(^popBlock)(void);
@property (nonatomic, copy) NSString *oldPhone;
@end
