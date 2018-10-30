//
//  ShopCar_PackageModel.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/30.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ShopCar_PackageModel.h"

@implementation ShopCar_PackageModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"packageChargeItemDOList" : @"ShopCar_PackageChargeItemModel"
             };
}

@end

@implementation ShopCar_PackageChargeItemModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end
@implementation ShopCar_PackageProductDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end
