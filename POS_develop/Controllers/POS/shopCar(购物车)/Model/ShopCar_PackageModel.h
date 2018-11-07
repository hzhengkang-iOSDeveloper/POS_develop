//
//  ShopCar_PackageModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/30.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCar_PackageModel : NSObject
@property (nonatomic,assign)NSUInteger goodCount;//记录商品增减数量
@property (nonatomic, assign) BOOL isSelected;//是否被选中
@property (nonatomic, copy) NSString *pkgPrdType;
@property (nonatomic, copy) NSString *h5Url;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbProductId;
@property (nonatomic, copy) NSString *packageName;
@property (nonatomic, copy) NSString *packagePrice;
@property (nonatomic, copy) NSString *originPrice;
@property (nonatomic, copy) NSString *packagePic;
@property (nonatomic, copy) NSString *recommendStar;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, copy) NSString *recommendType;
@property (nonatomic, copy) NSString *countInPackage;
@property (nonatomic, strong) NSArray *packageChargeItemDOList;
@property (nonatomic, strong) NSArray *packageFreeItemDOList;

@end

@interface ShopCar_PackageChargeItemModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbPkgFreeId;
@property (nonatomic, copy) NSString *tbProductId;
@property (nonatomic, copy) NSString *posCount;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, strong) NSDictionary *productDO;
@end

@interface ShopCar_PackageFreeItemModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbPkgFreeId;
@property (nonatomic, copy) NSString *tbProductId;
@property (nonatomic, copy) NSString *posCount;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, strong) NSDictionary *productDO;
@end


@interface ShopCar_PackageProductDOModel : NSObject
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
