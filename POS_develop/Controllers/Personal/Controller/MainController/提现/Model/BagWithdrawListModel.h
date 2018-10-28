//
//  BagWithdrawListModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagWithdrawListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *withdrawStatus;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *bankUser;
@property (nonatomic, copy) NSString *bankUserNo;
@property (nonatomic, copy) NSString *bankUserMp;
@property (nonatomic, copy) NSString *bankUserId;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankBranchName;
@property (nonatomic, copy) NSString *bankProvince;
@property (nonatomic, copy) NSString *bankCity;
@property (nonatomic, copy) NSString *bankCounty;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, copy) NSString *withDrawPasswd;
@end

NS_ASSUME_NONNULL_END
