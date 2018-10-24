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

@implementation DetailDOModel
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
