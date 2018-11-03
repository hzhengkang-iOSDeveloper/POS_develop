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
@property (nonatomic, copy) NSString *cosignTime;
@property (nonatomic, copy) NSString *shippingCode;
@property (nonatomic, copy) NSString *shippingName;
@property (nonatomic, strong) NSArray *detailDOList;
@property (nonatomic, strong) NSDictionary *payDO;
@property (nonatomic, strong) NSDictionary *addressDO;
@end

//地址信息
@interface AddressDOModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbOrderId;
@property (nonatomic, copy) NSString *tbAddressId;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, copy) NSString *receiverMp;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *receiverAddr;
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
@property (nonatomic, copy) NSString               *itemPic;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic, strong) NSDictionary               *itemObj;
@end

@interface ItemObjModel : NSObject
//套餐
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * packageName;
@property (nonatomic , copy) NSString              * packagePrice;
@property (nonatomic , copy) NSString              * originPrice;
@property (nonatomic , copy) NSString              * packagePic;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * deleteflag;
@property (nonatomic, strong) NSArray * packageChargeItemDOList;

//产品
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posBrandName;
@property (nonatomic, copy) NSString *posTermType;
@property (nonatomic, copy) NSString *posTermModel;
@property (nonatomic, copy) NSString *posSnNo;
@property (nonatomic, copy) NSString *activationType;
@property (nonatomic, copy) NSString *posPrice;
@property (nonatomic, copy) NSString *posRebatePrice;
@property (nonatomic, copy) NSString *posCount;
@property (nonatomic, copy) NSString *productImg;
@property (nonatomic, copy) NSString *chargeType;
@property (nonatomic, copy) NSString *productName;
@end

@interface PackAgeChargeItemListModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * tbPkgChargeId;
@property (nonatomic , copy) NSString              * tbProductId;
@property (nonatomic , copy) NSString              * posCount;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * deleteflag;
@property (nonatomic , strong) NSDictionary              * productDO;
@end

@interface ProductDOModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * posBrandNo;
@property (nonatomic , copy) NSString              * posBrandName;
@property (nonatomic , copy) NSString              * posTermType;
@property (nonatomic , copy) NSString              * posTermModel;
@property (nonatomic , copy) NSString              * posSnNo;
@property (nonatomic , copy) NSString              * activationType;
@property (nonatomic , copy) NSString              * posPrice;
@property (nonatomic , copy) NSString              * posRebatePrice;
@property (nonatomic , copy) NSString              * posCount;
@property (nonatomic , copy) NSString              * productImg;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * deleteflag;
@property (nonatomic,  copy) NSString               *productName;
@end

@interface PayDOModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * payDescription;
@property (nonatomic , copy) NSString              * payBankTransUuid;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * payBankUserNo;
@property (nonatomic , copy) NSString              * correctCallback;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * payBankImage;
@property (nonatomic , copy) NSString              * tbOrderId;
@property (nonatomic , copy) NSString              * payBankUser;
@property (nonatomic , copy) NSString              * transactionId;
@property (nonatomic , copy) NSString              * callbackLog;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic, copy) NSString               *outTradeNumber;
@property (nonatomic , copy) NSString              * callbackDate;
@property (nonatomic , copy) NSString              * deleteflag;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic, copy) NSString               * payUuid;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * payBankName;
@property (nonatomic , copy) NSString              * orderPrice;
@end

