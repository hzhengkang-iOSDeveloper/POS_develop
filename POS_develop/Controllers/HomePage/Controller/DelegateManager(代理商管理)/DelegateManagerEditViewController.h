//
//  DelegateManagerEditViewController.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BaseSonViewController.h"
@class AgentListModel;
NS_ASSUME_NONNULL_BEGIN

@interface DelegateManagerEditViewController : BaseSonViewController
@property (nonatomic, strong) AgentListModel *model;
@property (nonatomic, copy) void(^popBlock)(void);
@end

NS_ASSUME_NONNULL_END
