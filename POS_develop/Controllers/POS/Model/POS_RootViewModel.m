//
//  POS_RootViewModel.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_RootViewModel.h"

@implementation POS_RootViewModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"packageFreeItemDOList" : @"POS_RootPackageFreeModel"
             };
}

@end

@implementation POS_RootPackageFreeModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end
@implementation POS_RootProductDOModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
    
}
@end
