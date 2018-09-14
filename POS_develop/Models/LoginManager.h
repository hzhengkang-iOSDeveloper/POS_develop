//
//  LoginManager.h
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
//#import "BankCardModel.h"

typedef void(^HPDLoginResult)(BOOL success, NSDictionary *result);
typedef void(^HPDLogoutResult)(BOOL success, NSDictionary *result);

extern NSString *const kLoginFaildNofication;
extern NSString *const kLogoutSuccessNotification;

extern NSString *const kShouldShowLoginViewController;
extern NSString *const kShouldShowLoginViewControllerLogout;


@interface LoginManager : NSObject
{
    NSHTTPCookie *_userCookie;
    BOOL _wasLogin;
}

@property (nonatomic, strong, readonly) UserInfo *userInfo;

@property (nonatomic, strong, readonly) NSHTTPCookie *userCookie;
@property (nonatomic, readonly, getter = wasLogin) BOOL wasLogin;
@property (nonatomic, strong) NSArray *userCookies;

+ (LoginManager *)getInstance;

- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password result:(HPDLoginResult)loginResult;

- (void)refreshCookie;

- (void)logoutWithResult:(HPDLogoutResult)result;

- (void)wasLoginIsNo;

- (void)loginSuccess:(NSDictionary *)result account:(NSString*)account;

- (void)loginFaild:(NSDictionary *)result;

- (void)cleanUserInfo;
@end
