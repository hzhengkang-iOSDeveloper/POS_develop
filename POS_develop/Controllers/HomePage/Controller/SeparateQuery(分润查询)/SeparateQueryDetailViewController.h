//
//  SeparateQueryDetailViewController.h
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeparateQueryDetailViewController : BaseSonViewController
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *agentType;
@end

NS_ASSUME_NONNULL_END
