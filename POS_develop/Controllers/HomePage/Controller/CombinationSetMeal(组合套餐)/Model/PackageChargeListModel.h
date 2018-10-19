//
//  PackageChargeListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageChargeListModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *packageName;
@property (nonatomic, copy) NSString *packagePrice;
@property (nonatomic, copy) NSString *originPrice;
@property (nonatomic, copy) NSString *packagePic;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, strong) NSArray *packageChargeItemDOList;
@end


@interface packageChargeItemDOListModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * tbPkgChargeId;
@property (nonatomic , copy) NSString              * tbProductId;
@property (nonatomic , copy) NSString              * posCount;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * createusername;
@property (nonatomic , copy) NSString              * updateuserno;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * deleteflag;
@property (nonatomic, strong) NSDictionary         * productDO;

@end
