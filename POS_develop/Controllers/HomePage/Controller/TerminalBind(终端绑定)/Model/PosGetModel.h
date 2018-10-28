//
//  PosGetModel.h
//  POS_develop
//
//  Created by syn on 2018/10/23.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PosGetModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *agentId;
@property (nonatomic, copy) NSString *posId;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posBrandName;
@property (nonatomic, copy) NSString *bindFlag;
@property (nonatomic, copy) NSString *posTermType;
@property (nonatomic, copy) NSString *posTermModel;
@property (nonatomic, copy) NSString *posSnNo;
@property (nonatomic, copy) NSString *startPosSnNo;
@property (nonatomic, copy) NSString *endPosSnNo;
@property (nonatomic, copy) NSString *activationType;
@property (nonatomic, copy) NSString *sceneType;
@property (nonatomic, copy) NSString *activationTime;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end
