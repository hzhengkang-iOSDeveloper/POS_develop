//
//  BillListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/18.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *orderUuid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *displayPrice;
@property (nonatomic, copy) NSString *discountPrice;
@property (nonatomic, copy) NSString *deliveryPrice;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, strong) NSArray *detailDOList;
@property (nonatomic, strong) NSDictionary *payDO;
@property (nonatomic, strong) NSDictionary *addressDO;
@end
@interface DetailDOModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * tbOrderId;
@property (nonatomic , copy) NSString              * displayPrice;
@property (nonatomic , copy) NSString              * discountPrice;
@property (nonatomic , copy) NSString              * deliveryPrice;
@property (nonatomic , copy) NSString              * orderPrice;
@property (nonatomic , copy) NSString              * itemId;
@property (nonatomic , copy) NSString              * itemType;
@property (nonatomic , copy) NSString              * itemCount;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * deleteflag;

@end
