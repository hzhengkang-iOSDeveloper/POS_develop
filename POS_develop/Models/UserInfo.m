//
//  UserInfo.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)clean
{
    self.userId = nil;
    self.authCode = nil;
    self.invitedCode = nil;
    self.kycState = nil;
    self.mobile = nil;
    self.nickname = nil;
}

- (void)valueFromeDict:(NSDictionary *)result
{
    
}

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

@end
