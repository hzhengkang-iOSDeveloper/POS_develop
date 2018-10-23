//
//  AgentListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/21.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *sbLevel;
@property (nonatomic, copy) NSString *sbLevelVip;
@property (nonatomic, copy) NSString *creditLevel;
@property (nonatomic, copy) NSString *agentType;
@property (nonatomic, copy) NSString *drawCount;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;

@end
