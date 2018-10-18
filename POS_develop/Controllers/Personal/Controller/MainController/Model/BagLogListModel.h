//
//  BagLogListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/18.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BagLogListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userid; //是否是默认地址，0:是，1:否
@property (nonatomic, copy) NSString *balanceAmount;
@property (nonatomic, copy) NSString *balanceType;
@property (nonatomic, copy) NSString *balanceStatus;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;

@end
