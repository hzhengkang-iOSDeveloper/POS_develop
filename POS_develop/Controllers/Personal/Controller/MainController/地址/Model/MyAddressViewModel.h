//
//  MyAddressViewModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/14.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAddressViewModel : NSObject
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *defaultFlag; //是否是默认地址，0:是，1:否
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *receiverAddr;
@property (nonatomic, copy) NSString *receiverMp;
@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *province;//省
@property (nonatomic, copy) NSString *city;//市
@property (nonatomic, copy) NSString *county;//区

@end

NS_ASSUME_NONNULL_END
