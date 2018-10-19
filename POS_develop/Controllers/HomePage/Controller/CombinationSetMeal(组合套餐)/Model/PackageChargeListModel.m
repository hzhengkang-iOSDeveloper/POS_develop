//
//  PackageChargeListModel.m
//  POS_develop
//
//  Created by syn on 2018/10/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PackageChargeListModel.h"

@implementation PackageChargeListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"packageChargeItemDOList" : @"packageChargeItemDOListModel"
             };
}

@end

@implementation packageChargeItemDOListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end
