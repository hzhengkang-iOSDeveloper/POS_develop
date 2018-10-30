//
//  ShopCarModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/22.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 "id": 18,
 "userid": "1",
 "pkgPrdId": 1,
 "pkgPrdType": 1,
 "count": 1,
 "operation": 1,
 "createtime": "2018-10-30 12:00:20",
 "createusername": null,
 "updateuserno": null,
 "updatetime": null,
 "deleteflag": 0
 */
@interface ShopCarModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *pkgPrdId;
@property (nonatomic, copy) NSString *pkgPrdType;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *operation;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end

NS_ASSUME_NONNULL_END
