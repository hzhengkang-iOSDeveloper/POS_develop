//
//  LoginManager.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "LoginManager.h"
#import "HPDConnect.h"
#import "StaticLibrary.h"
#import "MyStatic.h"
#import "RSA+AES+GZIP.h"
#import <Growing.h>
#import "HDeviceIdentifier.h"
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
        if ([USER_DEFAULT objectForKey:CF_LastUserDic] != nil) {
            NSLog(@"LastUserDic = %@",[USER_DEFAULT objectForKey:CF_LastUserDic]);
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
    //_userInfo = nil;
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
                [self loginSuccess:result account:account];
//                NSDictionary *dictTemp = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
#pragma mark 登陆账户验证码
                
//                NSDictionary *LastUserDic = @{ACCOUNT:account, NICKNAME:dictTemp[@"Nick_Name"], USERPHOTO:dictTemp[@"Photo_Url"], ISSETPWD:dictTemp[@"IsSetPwd"], CUST_CODE:dictTemp[@"Cust_Code"]};
//                [[NSUserDefaults standardUserDefaults] setValue:LastUserDic forKey:ZX_LastUserDic];
                
                [USER_DEFAULT synchronize];
                
//                NSLog(@"%@",[[USER_DEFAULT objectForKey:ZX_LastUserDic] objectForKey:NICKNAME]);
                loginResult(YES, result);
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
//            if (success && [[result valueForKey:kSoapResponseStatu] intValue] == 1) {
                [self loginSuccess:result account:account];
                
#pragma mark 保存最后一次登陆账户密码
//                NSDictionary *dictTemp = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
//                NSDictionary *LastUserDic = @{ACCOUNT:account,PASSWORD:password, NICKNAME:dictTemp[@"Nick_Name"], USERPHOTO:dictTemp[@"Photo_Url"], ISSETPWD:dictTemp[@"IsSetPwd"], CUST_CODE:dictTemp[@"Cust_Code"]};
//                [USER_DEFAULT setObject:LastUserDic forKey:ZX_LastUserDic];
//                [USER_DEFAULT synchronize];
            
                loginResult(YES, result);
//            }
//            else {
//                [self loginFaild:result];
//                loginResult(NO, result);
//            }
            
        }else{
            [self loginFaild:result];
            loginResult(NO, result);
            //            showToast(kErrorMsg);
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
    
//    [self storeCookie];
//
//    _userInfo.phoneNumber = account;
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result[@"doObject"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers  error:nil];
//    _userInfo.nice_name = dict[@"nice_name"];
//
//    _userInfo.customerCode = dict[@"customer_code"];
//    if ([[dict allKeys] containsObject:@"user_id"]) {
//        _userInfo.userId = dict[@"user_id"];
//    }
    
}

- (void)loginFaild:(NSDictionary *)result
{
//    if ([result[@"doObject"]isEqualToString:@"111124"]) {
//        _wasLogin = NO;
//        _userInfo.customerCode = nil;
//        _userInfo.nice_name = nil;
//        [USER_DEFAULT removeObjectForKey:CF_LastUserDic];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:result];
//    }
    _wasLogin = NO;
//    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFaildNofication object:result];
}

- (void):(HPDLogoutResult)logoutResult
{

    [self cleanUserInfo];
    [[HPDConnect connect] webservicesAFNetPOSTMethod
     :kSoapMethodUserLogout params:nil cookie:self.userCookie result:^(bool success, NSDictionary *result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:result];
        logoutResult(YES, nil);
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
        for (id obj in _tmpArray) {
            [cookieJar deleteCookie:obj];
        }
        
        self.userCookies = nil;
        _userCookie = nil;
    }];
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
