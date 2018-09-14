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
    self.nice_name = nil;
    self.password = nil;
    self.email = nil;
    self.phoneNumber = nil;
    self.fundTotle = nil;
    self.balance = nil;
    self.personal_assets = nil;
    self.freezFund = nil;
    self.ungetInterest = nil;
    self.ungetIntefund = nil;
    self.getInterest = nil;
    self.realName = nil;
    self.cardID = nil;
    self.customerCode = nil;
    self.JXQList = nil;
    self.cardCount = nil;
//    self.MessageCount = nil;
//    self.Autograph = nil;
//    self.UserImg = nil;
//    self.nice_name = nil;
//    self.mobile_phone = nil;
}

- (void)valueFromeDict:(NSDictionary *)result
{
    self.realName = [result valueForKeyPath:@"real_name"];
    self.balance = [result valueForKeyPath:@"balance"];
    self.personal_assets = [result valueForKeyPath:@"personal_assets"];
    self.getInterest = [result valueForKeyPath:@"get_interest"];
    self.ungetIntefund = [result valueForKeyPath:@"unget_intefund"];
    self.freezFund = [result valueForKeyPath:@"freez_fund"];
    self.fundTotle = [result valueForKeyPath:@"fund_totle"];
    self.ungetInterest = [result valueForKeyPath:@"unget_interest"];
    self.cardID = [result valueForKeyPath:@"idcard"];
    self.JXQList = [result valueForKeyPath:@"JXQList"];
    self.cardCount = [result valueForKeyPath:@"cardCount"];
//    self.MessageCount = [result valueForKey:@"MessageCount"];
//    self.Autograph = [result valueForKey:@"Autograph"];
//    self.UserImg = [result valueForKey:@"UserImg"];
//    self.nice_name = [result valueForKey:@"nice_name"];
//    self.mobile_phone = [result valueForKey:@"mobile_phone"];
}

- (id)init
{
    if (self = [super init]) {
        _userInfoWasRequesed = NO;
    }
    return self;
}

@end
