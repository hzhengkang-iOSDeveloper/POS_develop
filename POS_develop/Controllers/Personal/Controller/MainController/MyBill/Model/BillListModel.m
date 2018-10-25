//
//  BillListModel.m
//  POS_develop
//
//  Created by syn on 2018/10/18.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BillListModel.h"

@implementation BillListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"detailDOList" : @"DetailDOModel"
             };
}


@end

@implementation AddressDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end

@implementation DetailDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}


@end

@implementation ItemObjModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"packageChargeItemDOList" : @"PackAgeChargeItemListModel"
             };
}
@end


@implementation PackAgeChargeItemListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end

@implementation ProductDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end


@implementation PayDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id",
                  @"payDescription" : @"description"
             };
    
}

@end
