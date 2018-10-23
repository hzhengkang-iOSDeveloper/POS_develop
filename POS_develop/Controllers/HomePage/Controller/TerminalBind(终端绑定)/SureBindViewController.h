//
//  SureBindViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SureBindViewController : BaseSonViewController
@property (nonatomic, copy) NSString *posID;
@property (nonatomic, copy) NSString *agentId;
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posSnNo;
@property (nonatomic, copy) void(^popBlock)(void);

@end

NS_ASSUME_NONNULL_END
