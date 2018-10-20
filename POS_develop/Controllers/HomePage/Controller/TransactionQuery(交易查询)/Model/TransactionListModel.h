//
//  TransactionListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *posTermNo;
@property (nonatomic, copy) NSString *posSnNo;
@property (nonatomic, copy) NSString *transAccount;
@property (nonatomic, copy) NSString *transAmount;
@property (nonatomic, copy) NSString *transType;
@property (nonatomic, copy) NSString *unionRetCode;
@property (nonatomic, copy) NSString *transResult;
@property (nonatomic, copy) NSString *transStatus;
@property (nonatomic, copy) NSString *transTime;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *touchWay;
@property (nonatomic, copy) NSString *transUuid;
@property (nonatomic, copy) NSString *systemRefCode;
@property (nonatomic, copy) NSString *systemFollowCode;
@property (nonatomic, copy) NSString *transRefCode;
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posBrandName;
@property (nonatomic, copy) NSString *agentType;
@property (nonatomic, copy) NSString *dayId;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createuserno;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end
