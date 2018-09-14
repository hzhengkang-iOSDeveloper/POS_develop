//
//  NSUserDefaults+Helper.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/10.
//  Copyright © 2017年 孙亚男. All rights reserved.
//


#import "NSUserDefaults+Helper.h"

@implementation NSUserDefaults (Helper)

- (void)clear {
    [self removeObjectForKey:@"isLenit"];
}

- (BOOL)didAccess {
    return [self boolForKey:@"didAccess"];
}
-(BOOL)isLenit{
    return [self boolForKey:@"isLenit"];
}
-(BOOL)iS_RealAuthentication{
    return [self boolForKey:@"iS_RealAuthentication"];
}
-(BOOL)iS_BindCard{
    return [self boolForKey:@"iS_BindCard"];
}




-(void)setIsLenit:(BOOL)isLenit{
    [self setBool:isLenit forKey:@"isLenit"];
}
- (void)setDidAccess:(BOOL)didAccess {
    [self setBool:didAccess forKey:@"didAccess"];
}
-(void)setIS_RealAuthentication:(BOOL)iS_RealAuthentication{
    [self setBool:iS_RealAuthentication forKey:@"iS_RealAuthentication"];
}
-(void)setIS_BindCard:(BOOL)iS_BindCard{
     [self setBool:iS_BindCard forKey:@"iS_BindCard"];
}
@end
