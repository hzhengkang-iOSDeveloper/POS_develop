//
//  LoginManager.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "LoginManager.h"
#import "HPDConnect.h"
#import <Growing.h>
#import "HDeviceIdentifier.h"
#import "LoginTypeViewController.h"
NSString *const kLoginFaildNofication = @"kLoginFaildNofication";
NSString *const kLogoutSuccessNotification = @"kLogoutSuccessNotification";
NSString *const kShouldShowLoginViewController = @"kShouldShowLoginViewController";
NSString *const kShouldShowLoginViewControllerLogout = @"kShouldShowLoginViewControllerLogout";

@implementation LoginManager

+ (LoginManager *)getInstance
{
    static LoginManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[LoginManager alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        _userInfo = [[UserInfo alloc] init];
        if ([USER_DEFAULT objectForKey:UserDict] != nil) {
            NSLog(@"UserDict = %@",[USER_DEFAULT objectForKey:UserDict]);
            _wasLogin = YES;
        }else{
            _wasLogin = NO;
        }
    }
    return self;
}

- (void)refreshCookie
{
    [self storeCookie];
}

- (void)storeCookie
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    if ([[cookieJar cookies] count] > 0) {
        _userCookies = [cookieJar cookies];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            if ([cookie.name isEqualToString:@"ASP.NET_SessionId"]) {
                //NSLog(@"oldrCookie = %@",_userCookie);
                _userCookie = cookie;
                NSLog(@"newCookie = %@",_userCookie);
                break;
            }
        }
#if DEBUG
        if (_userCookie == nil) {
            NSLog(@"no cookie is userd");
        }
#endif
    }
    else {
#ifdef DEBUG
        NSLog(@"no cookie to store");
#endif
    }

}

- (void)cleanUserInfo
{
    [self.userInfo clean];
    [USER_DEFAULT removeObjectForKey:UserDict];

}

- (void)wasLoginIsNo{
    _wasLogin = NO;
}
- (void)loginFastWithAccount:(NSString *)account andSmsCode:(NSString *)smsCode result:(HPDLoginResult)loginResult {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    _userCookies = nil;
    _userCookie = nil;
    NSDictionary *dict = @{@"mobile":account, @"smsCode":smsCode, @"deviceId":[HDeviceIdentifier deviceIdentifier]};
    [[HPDConnect connect]PostOtherNetRequestMethod:@"login" params:dict cookie:nil result:^(bool success, id result) {
        
        if (success) {
//            if (success && [[result valueForKey:kSoapResponseStatu] intValue] == 1) {
            if ([result[@"code"]integerValue] == 0) {
                [self loginSuccess:result account:account];
                [USER_DEFAULT synchronize];
                loginResult(YES, result);

            } else {
                loginResult(NO,result);
            }
//                NSDictionary *dictTemp = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
#pragma mark 登陆账户验证码
                
//                NSDictionary *LastUserDic = @{ACCOUNT:account, NICKNAME:dictTemp[@"Nick_Name"], USERPHOTO:dictTemp[@"Photo_Url"], ISSETPWD:dictTemp[@"IsSetPwd"], CUST_CODE:dictTemp[@"Cust_Code"]};
//                [[NSUserDefaults standardUserDefaults] setValue:LastUserDic forKey:ZX_LastUserDic];
                
                [USER_DEFAULT synchronize];
                
//                NSLog(@"%@",[[USER_DEFAULT objectForKey:ZX_LastUserDic] objectForKey:NICKNAME]);
//            }
//            else {
//                [self loginFaild:result];
//                loginResult(NO, result);
//            }
            
        }else{
            [self loginFaild:result];
            loginResult(NO, result);
        }
        
    } ];
    
   
   

}

- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password result:(HPDLoginResult)loginResult
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    _userCookies = nil;
    _userCookie = nil;
    NSDictionary *dict = @{@"mobile":account, @"password":password, @"deviceId":[HDeviceIdentifier deviceIdentifier]};
    [[HPDConnect connect] PostOtherNetRequestMethod:@"login2" params:dict cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"] integerValue] == 0) {
                [self loginSuccess:result account:account];
                [USER_DEFAULT synchronize];
                loginResult(YES, result);
                
            } else {
                loginResult(NO,result);
            }
            
#pragma mark 保存最后一次登陆账户密码
//                NSDictionary *dictTemp = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
//                NSDictionary *LastUserDic = @{ACCOUNT:account,PASSWORD:password, NICKNAME:dictTemp[@"Nick_Name"], USERPHOTO:dictTemp[@"Photo_Url"], ISSETPWD:dictTemp[@"IsSetPwd"], CUST_CODE:dictTemp[@"Cust_Code"]};
//                [USER_DEFAULT setObject:LastUserDic forKey:ZX_LastUserDic];
//                [USER_DEFAULT synchronize];
            
//            }
//            else {
//                [self loginFaild:result];
//                loginResult(NO, result);
//            }
            
        }else{
            [self loginFaild:result];
            loginResult(NO, result);
        }
        
    }];
    
   

}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)loginSuccess:(NSDictionary *)result account:(NSString*)account
{
    _wasLogin = YES;
    NSDictionary *dict = result[@"data"];
    _userInfo.userId = [dict valueForKey:@"userId"];
    _userInfo.authCode = [dict valueForKey:@"authCode"];
    _userInfo.nickname = [dict valueForKey:@"nickname"];
    
    NSLog(@"%@",[dict valueForKey:@"mobile"]);
    NSDictionary* dictInfo = @{USERID:_userInfo.userId,AUTHCODE : _userInfo.authCode, @"nickname":IF_NULL_TO_STRING(_userInfo.nickname),MOBILE:IF_NULL_TO_STRING([dict valueForKey:@"mobile"])};
    [USER_DEFAULT setObject:dictInfo forKey:UserDict];
    UserDefaultsSet(IF_NULL_TO_STRING([dict valueForKey:@"mobile"]), MOBILE);

    if ([dict[@"nickname"] isKindOfClass:[NSNull class]] || [dict[@"nickname"] isEqualToString:@""] || dict[@"nickname"] == nil) {
        UserDefaultsSet(@"默认用户", NICKNAME);
    } else {
        UserDefaultsSet(IF_NULL_TO_STRING([dict valueForKey:@"nickname"]), NICKNAME);
    }
    
    //保存用户头像
    UserDefaultsSet(@"头像", USERHEADERIMAGE);
    
    //保存邀请码
    UserDefaultsSet([dict objectForKey:@"invitedCode"], USER_INVITECODE);
    //注册环信
    [[HPDConnect connect]PostOtherNetRequestMethod:@"huanxin/register" params:@{@"userId":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        
    }];
    
}

- (void)loginFaild:(NSDictionary *)result
{

//        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:result];

    _userInfo.userId = nil;
    _userInfo.authCode = nil;
    _userInfo.nickname = nil;
    _wasLogin = NO;
    [USER_DEFAULT removeObjectForKey:UserDict];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFaildNofication object:result];
}

- (void)loginOut:(HPDLogoutResult)logoutResult
{
    [[HPDConnect connect] GetNetRequestMethod:@"logout" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                [self cleanUserInfo];
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
                for (id obj in _tmpArray) {
                    [cookieJar deleteCookie:obj];
                }
                
                self.userCookies = nil;
                _userCookie = nil;
                
                
                
                
//                HUD_TIP(@"退出成功");
                LoginTypeViewController * baseVC = [[LoginTypeViewController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = baseVC;
            }
            
        
            
        }
    }];
//    [[HPDConnect connect] webservicesAFNetPOSTMethod
//     :kSoapMethodUserLogout params:nil cookie:self.userCookie result:^(bool success, NSDictionary *result) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:result];
//        logoutResult(YES, nil);
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
//        for (id obj in _tmpArray) {
//            [cookieJar deleteCookie:obj];
//        }
//        
//        self.userCookies = nil;
//        _userCookie = nil;
//    }];
}







- (NSString *)realName:(NSString *)idRealName
{
    NSRange range = [idRealName rangeOfString:@"("];
    return [idRealName substringToIndex:range.location];
}

- (NSString *)idCardNumber:(NSString *)idRealName
{
    NSRange range1 = [idRealName rangeOfString:@"("];
    NSRange range2 = [idRealName rangeOfString:@")"];
    return [idRealName substringWithRange:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
}




- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil || [jsonString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
