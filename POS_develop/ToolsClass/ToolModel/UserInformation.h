//
//  UserInformation.h
//  ZNSuperWallet
//
//  Created by 赵诣 on 2016/10/21.
//  Copyright © 2016年 赵诣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

+ (id)getUserinfoWithKey:(NSString *)key;

+ (NSString *)getUserinfoStrValueForKey:(NSString *)key;

+ (void)saveUserinfoWithKey:(NSString *)key value:(id)value;

+ (void)saveUserinfoWithDictionary:(NSDictionary *)dictionary;

@end
