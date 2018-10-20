//
//  SeparateQueryRootViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/26.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeparateQueryRootViewController : BaseSonViewController
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *agentType;

- (void)loadShareBenefitListRequest:(NSString *)orderBy;
@end

NS_ASSUME_NONNULL_END
