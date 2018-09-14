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
        
        if ([GlobalMethod portCacheIsNo:KSoapMethonGetUserOtherInfo]) {///判断缓存是否存在
            NSDictionary* cacheDic = [USER_DEFAULT objectForKey:KSoapMethonGetUserOtherInfo];
            [self SetUserOtherInfoDic:cacheDic];
        }
        
        if ([GlobalMethod portCacheIsNo:kSoapMethodWhetherCertification]) {///判断缓存是否存在
            NSDictionary* cacheDic = [USER_DEFAULT objectForKey:kSoapMethodWhetherCertification];
            self.userInfo.whetherCertification = [[cacheDic valueForKey:kSoapResponseStatu] boolValue];
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

- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password result:(HPDLoginResult)loginResult
{
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    _userCookies = nil;
    _userCookie = nil;
    [[HPDConnect connect]webservicesAFNetPOSTMethod:@"Unify_User_Login"  params:@{@"Login_Name":account,@"Login_Pwd":password,@"device_name":[GlobalMethod deviceModelName]} cookie:nil result:^(bool success, NSDictionary *result) {
        

        if (success) {
            if (success && [[result valueForKey:kSoapResponseStatu] intValue] == 1) {
                NSDictionary* dic = [GlobalMethod dictionaryWithJsonString:[result valueForKey:@"doObject"]];
//                [Growing setCS1Value:dic[@"user_id"] forKey:@"user_id"];
                [self loginSuccess:result account:account];
                NSString* pushtag = dic[@"Push_Tag"];
                NSSet * set = [[NSSet alloc] initWithObjects:[[[LoginManager getInstance] userInfo] userId], @"ios",pushtag,nil];
#pragma mark 发送别名
                
//                NSString *str = [JPUSHService registrationID];
//                NSLog(@"%@",str);
                
//                [JPUSHService setTags:nil alias:[[[LoginManager getInstance] userInfo] userId]callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//                [JPUSHService setTags:set
//                                alias:[[[LoginManager getInstance] userInfo] userId]
//                     callbackSelector:@selector(tagsAliasCallback:tags:alias:)
//                               object:self];
#pragma mark 保存最后一次登陆账户密码
                NSDictionary* LastUserDic = @{@"login_name":account,@"login_pwd" : password};
                [USER_DEFAULT setObject:LastUserDic forKey:CF_LastUserDic];
                
                
                loginResult(YES, result);
            }
            else {
                [self loginFaild:result];
                loginResult(NO, result);
            }

        }else{
            loginResult(NO, result);
//            showToast(kErrorMsg);
        }
        
    } ];

}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)loginSuccess:(NSDictionary *)result account:(NSString*)account
{
    _wasLogin = YES;
    [self storeCookie];

    _userInfo.phoneNumber = account;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result[@"doObject"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers  error:nil];
    _userInfo.nice_name = dict[@"nice_name"];

    _userInfo.customerCode = dict[@"customer_code"];
    if ([[dict allKeys] containsObject:@"user_id"]) {
        _userInfo.userId = dict[@"user_id"];
    }
    [self requestForWitherCertification];
    

    [self requestGetUserOtherInfo];
    [self requestForUserDetailInfo];//用户基本信息（实名认证等）
    
}

- (void)loginFaild:(NSDictionary *)result
{
    if ([result[@"doObject"]isEqualToString:@"111124"]) {
        _wasLogin = NO;
        _userInfo.customerCode = nil;
        _userInfo.nice_name = nil;
        [USER_DEFAULT removeObjectForKey:CF_LastUserDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:result];
    }
    _wasLogin = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFaildNofication object:result];
}

- (void)logoutWithResult:(HPDLogoutResult)logoutResult
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
        
        _userCookies = nil;
        _userCookie = nil;
    }];
}

- (void)requestForWitherCertification
{
    if ([GlobalMethod portCacheIsNo:kSoapMethodWhetherCertification]) {///判断缓存是否存在
        NSDictionary* cacheDic = [USER_DEFAULT objectForKey:kSoapMethodWhetherCertification];
        self.userInfo.whetherCertification = [[cacheDic valueForKey:kSoapResponseStatu] boolValue];
    }

    [[HPDConnect connect] webservicesAFNetPOSTMethod:kSoapMethodWhetherCertification params:nil cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
        if (success) {
            [GlobalMethod cacheCurrentPort:kSoapMethodWhetherCertification cacheDic:result];///缓存
            self.userInfo.whetherCertification = [[result valueForKey:kSoapResponseStatu] boolValue];
        }
    }];
}

- (void)requestGetUserOtherInfo{
    if ([GlobalMethod portCacheIsNo:KSoapMethonGetUserOtherInfo]) {///判断缓存是否存在
        NSDictionary* cacheDic = [USER_DEFAULT objectForKey:KSoapMethonGetUserOtherInfo];
        [self SetUserOtherInfoDic:cacheDic];
    }
    
    [[HPDConnect connect] webservicesAFNetPOSTMethod:KSoapMethonGetUserOtherInfo params:nil cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
        if (success) {
            if (result[@"doStatu"]&&result[@"doObject"]!=nil) {
                [GlobalMethod cacheCurrentPort:KSoapMethonGetUserOtherInfo cacheDic:result];///缓存
                [self SetUserOtherInfoDic:result];
            }
        }
    }];
}
- (void)requestForUserDetailInfo
{
    [[HPDConnect connect] webservicesAFNetPOSTMethod:kSoapMethodAccountInfoV2 params:nil cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
        if (success) {
            if ([[result valueForKey:kSoapResponseStatu] boolValue]&&[result[@"doStatu"]intValue] == 1) {
                [self successToRequestUserInfo:result];
            }
        }
    }];
}



- (void)successToRequestUserInfo:(NSDictionary *)result
{
    LoginManager *loginManager = [LoginManager getInstance];
    NSDictionary* data = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
//    [[loginManager userInfo] setEmail:[result valueForKeyPath:@"doObject.mail"]];
    loginManager.userInfo.idCardAndRealName = [data objectForKey:@"real_auth"];
    loginManager.userInfo.cardCount =  [data objectForKey:@"cardCount"];
    //存储是否设置交易密码
    loginManager.userInfo.iseditpwd = [[[data objectForKey:@"iseditpwd"]stringValue]isEqualToString:@"1"]?YES:NO;

    if (loginManager.userInfo.idCardAndRealName && loginManager.userInfo.idCardAndRealName.length > 2) {
        loginManager.userInfo.realName = [self realName:[data objectForKey:@"real_auth"]];
        loginManager.userInfo.cardID = [self idCardNumber:[data objectForKey:@"real_auth"]];
    }
    
    loginManager.userInfo.phoneNumber = [data objectForKey:@"mobile_phone"];
    loginManager.userInfo.lastLogin = [data objectForKey:@"login_pwd"];
    loginManager.userInfo.nice_name = [data objectForKey:@"nice_name"];
    loginManager.userInfo.userInfoWasRequesed = YES;
    
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



-(void)SetUserOtherInfoDic:(NSDictionary*)result{
    NSDictionary * doObj;
    if ([result objectForKey:@"doObject"]) {
        doObj = [self dictionaryWithJsonString:[result objectForKey:@"doObject"]];
    }else{
        doObj = [result objectForKey:@"doObject"];
    }
    self.userInfo.Autograph = [NSString stringWithFormat:@"%@",[doObj objectForKey:@"Autograph"]];
    self.userInfo.UserImg = [NSString stringWithFormat:@"%@",[doObj objectForKey:@"UserImg"]];
    self.userInfo.nice_name = [NSString stringWithFormat:@"%@",[doObj objectForKey:@"nice_name"]];
    self.userInfo.mobile_phone = [NSString stringWithFormat:@"%@",[doObj objectForKey:@"mobile_phone"]];
    self.userInfo.myfooturl =[NSString stringWithFormat:@"%@",[doObj objectForKey:@"myfooturl"]];
    self.userInfo.MessageCount = [NSString stringWithFormat:@"%@",[doObj objectForKey:@"MessageCount"]];
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
