//
//  UserInformation.m
//  ZNSuperWallet
//
//  Created by 赵诣 on 2016/10/21.
//  Copyright © 2016年 赵诣. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

+ (id)getUserinfoWithKey:(NSString *)key
{
    if (IS_STRING(key)) {
        if ([USER_DEFAULT valueForKey:key]) {
            return [USER_DEFAULT valueForKey:key];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

+ (NSString *)getUserinfoStrValueForKey:(NSString *)key
{
    if (IS_STRING(key)) {
        if ([USER_DEFAULT valueForKey:key]) {
            return [USER_DEFAULT valueForKey:key];
        } else {
            return @"";
        }
    } else {
        return @"";
    }
}

+ (void)saveUserinfoWithKey:(NSString *)key value:(id)value
{
    if (IS_STRING(key)) {
        if (value) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                if ([value objectForKey:@"errCode"]) {
                    if ([[value objectForKey:@"errCode"] isEqual:[NSNull null]] || [[value objectForKey:@"errCode"] isEqualToString:@"(null)"]) {
                        value[@"errCode"] = @"";
                    }
                }
                if ([value objectForKey:@"prompt"]) {
                    if ([[value objectForKey:@"prompt"] isEqual:[NSNull null]]) {
                        value[@"prompt"] = @"";
                    }
                }
            }
           
            [USER_DEFAULT setObject:value forKey:key];
            [USER_DEFAULT synchronize];
        } else {
            NSLog(@"~~~~~~~~~~~~~~~~~存储失败，value = nil , key = %@", key);
        }
    } else {
        NSLog(@"~~~~~~~~~~~~~~~~~存储失败，key:%@", key);
    }
}

+ (void)saveUserinfoWithDictionary:(NSDictionary *)dictionary
{
    if (IS_DICTIONARY(dictionary) && dictionary.allKeys > 0) {
        for (NSString *key in dictionary.allKeys) {
            [USER_DEFAULT setObject:IS_STRING([dictionary objectForKey:key]) ? [dictionary objectForKey:key] : @"" forKey:key];
        }
        [USER_DEFAULT synchronize];
    } else {
        NSLog(@"~~~~~~~~~~~~~~~~~存储失败，字典有错误");
    }
}

@end
