//
//  ShareBenefitListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareBenefitListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *transType;
@property (nonatomic, copy) NSString *transAmount;
@property (nonatomic, copy) NSString *sbAmount;
@property (nonatomic, copy) NSString *transTime;
@property (nonatomic, copy) NSString *transAccount;
@property (nonatomic, copy) NSString *systemRefCode;
@property (nonatomic, copy) NSString *posTermNo;
@property (nonatomic, copy) NSString *transSettleDate;
@property (nonatomic, copy) NSString *agentType;
@property (nonatomic, copy) NSString *dayId;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, copy) NSString *orderBy;
@end
