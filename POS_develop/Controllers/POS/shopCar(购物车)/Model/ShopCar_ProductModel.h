//
//  ShopCar_ProductModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/30.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 "id": 1,
 "posBrandNo": "testa1",
 "posBrandName": "测试使用",
 "posTermType": "大型",
 "posTermModel": "testing1",
 "posSnNo": "00000001",
 "activationType": 0,
 "posPrice": 999,
 "posRebatePrice": 100,
 "posCount": 5,
 "productImg": "/files/保险.png",
 "chargeType": 1,
 "createtime": "2018-10-02 10:38:19",
 "createusername": null,
 "updateuserno": null,
 "updatetime": "2018-10-29 04:29:25",
 "deleteflag": 0
 */
@interface ShopCar_ProductModel : NSObject
@property (nonatomic,assign)NSUInteger goodCount;//记录商品增减数量
@property (nonatomic, assign) BOOL isSelected;//是否被选中
@property (nonatomic, copy) NSString *ID;
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
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end

NS_ASSUME_NONNULL_END
