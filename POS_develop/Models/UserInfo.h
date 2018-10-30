//
//  UserInfo.h
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *authCode;
@property (nonatomic, copy) NSString *invitedCode;
@property (nonatomic, copy) NSString *kycState;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
- (void)clean;

- (void)valueFromeDict:(NSDictionary *)dict;

@end
