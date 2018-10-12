//
//  HPDConnect.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "HPDConnect.h" 
#import "GDataXMLNode.h"
#import "GlobalMethod.h"
#import "MyTools.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "MyStatic.h"
#import "StaticLibrary.h"
#import "RSA+AES+GZIP.h"
#import "HDeviceIdentifier.h"
@implementation HPDConnect

//生产环境
#define  kFormalURL      @"https://api.hepancaifu.com/"

//测试环境
#define  newLocalHost    @"http://106.14.7.85:8000/"

#define  BaseHeaderURL   newLocalHost



+ (HPDConnect *)connect
{
    return [[HPDConnect alloc] init];
}

- (NSData *)soap12BodyWithMethod:(NSString *)method andParams:(NSDictionary *)params baseUrl:(NSString *)baseUrl
{
    GDataXMLElement *root = [GDataXMLElement elementWithName:@"soap12:Envelope"];
    [root addAttribute:[GDataXMLNode attributeWithName:@"xmlns:xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"]];
    [root addAttribute:[GDataXMLNode attributeWithName:@"xmlns:xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"]];
    [root addAttribute:[GDataXMLNode attributeWithName:@"xmlns:soap12" stringValue:@"http://www.w3.org/2003/05/soap-envelope"]];
    GDataXMLElement *bodyElement = [GDataXMLElement elementWithName:@"soap12:Body"];
    GDataXMLElement *methodElement = [GDataXMLElement elementWithName:method];
    [methodElement addAttribute:[GDataXMLNode attributeWithName:@"xmlns" stringValue:baseUrl]];
    if (params) {
        for (NSString *key in params.allKeys) {
            if ([[params valueForKey:key] isKindOfClass:[NSString class]]) {
                GDataXMLElement *childElement = [GDataXMLNode elementWithName:key stringValue:[params valueForKey:key]];
                [methodElement addChild:childElement];
            }
            else if ([[params valueForKey:key] isKindOfClass:[NSNumber class]]) {
                GDataXMLElement *childElement = [GDataXMLNode elementWithName:key stringValue:[[params valueForKey:key] stringValue]];
                [methodElement addChild:childElement];
            } 
            else {
                NSLog(@"error archive %@ to soap xml", [[params valueForKey:key] class]);
            }
        }
    }
    
    [bodyElement addChild:methodElement];
    [root addChild:bodyElement];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:root];
    [document setVersion:@"1.0"];
    [document setCharacterEncoding:@"utf-8"];
    return document.XMLData;
}

- (NSDictionary *)jsonSerialization:(NSData *)data
{
    NSError *error = nil;
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error to serialization the json data");
        return nil;
    }
    else {
        return (NSDictionary *)json;
    }
}

/**从xml中提取json*/
- (NSString *)selectJsonFromXml:(NSString *)xmlString
{
    if (!xmlString) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"\\{.*\\}" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"error to select json string from xml string ==> %@", xmlString);
        return nil;
    }
    else {
        NSTextCheckingResult *result = [regular firstMatchInString:xmlString options:NSMatchingReportProgress range:NSMakeRange(0, xmlString.length)];
        if (result) {
            NSRange rangeResult = [result rangeAtIndex:0];
            return [xmlString substringWithRange:rangeResult];
        }
    }
    return nil;
}

- (NSURLRequest *)requestWithSoapMethod:(NSString *)method Params:(NSDictionary *)params Cookie:(NSHTTPCookie *)cookie
{
    NSString *baseUrl;
    NSString *methodName;
    NSDictionary *paramsDic;
    
   
    baseUrl = [NSString stringWithFormat:@"%@", BaseHeaderURL];
    methodName = method;
    paramsDic = params;

    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    NSData *body = [self soap12BodyWithMethod:methodName andParams:paramsDic baseUrl:@"http://www.hepandai.com"];
    [request addValue:[@(body.length) stringValue] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    if (cookie) {
        //[self setCookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    return request;
}

- (void)setCookie
{
    /*
    if ([[LoginManager getInstance] userCookies]) {
        for (NSHTTPCookie *cookie  in [[LoginManager getInstance] userCookies]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
     */
}

- (BOOL)wasNetworkValid
{
    return [[NetWorkDetectionManager defaultNetWorkDetection] isNetworkReachable];
}

- (BOOL)checkTheNetwork
{
    if ([self wasNetworkValid]) {
        return YES;
    }
    else {
        [UIAlertView showMessage:@"当前网络不可用，请稍后再试！"];
        return NO;
    }
}

- (void)ansySoapMethod:(NSString *)method params:(NSDictionary *)params result:(HPDRequestResultBlock)result
{
    [self ansySoapMethod:method params:params cookie:nil result:result];
}

- (void)ansySoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(HPDRequestResultBlock)result
{
//    if (![self wasNetworkValid]) {
//        showToast(@"请检查您的网络");
//#if DEBUG
//        NSLog(@"--->net work can not used!");
//#endif
//        result(NO, nil);
//        return;
//    }
#if DEBUG
    NSLog(@"--->soap method = %@  params = %@", method, [params urlParamsString]);
#endif
    NSURLRequest *request = [self requestWithSoapMethod:method Params:params Cookie:cookie];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError){
#if DEBUG
            NSLog(@"--->connenction error = %@", connectionError);
#endif
            dispatch_async(dispatch_get_main_queue(), ^{
                result(NO,nil);     // connect error
            });
        }else{
            NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *resultJson = [self selectJsonFromXml:resultString];
#if DEBUG
            // format the json string to print
            if (!resultJson) {
                NSLog(@"--->response str = nil");
            }
            else {
                NSData *data = [NSJSONSerialization dataWithJSONObject:[self jsonSerialization:[resultJson dataUsingEncoding:NSUTF8StringEncoding]] options:NSJSONWritingPrettyPrinted error:nil];
                NSLog(@"--->method = %@ response str = \n%@", method, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            }
#endif
            if (resultJson) {
                NSDictionary *dict = [self jsonSerialization:[resultJson dataUsingEncoding:NSUTF8StringEncoding]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(YES, dict);  // success
                });
                if (cookie) {       // should refresh cookie if the response has cookie
                    [[LoginManager getInstance] refreshCookie];
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(NO, nil);    // json serialization error
                });
            }
        }
    }];
}

#pragma mark ---  统一接口异步实现
//统一接口异步实现
- (void)ansySoapUintMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(HPDRequestResultBlock)result
{
//    if (![self wasNetworkValid]) {
//        if ([[UIApplication sharedApplication]keyWindow]) {
//            showToast(@"请检查您的网络")
//        }
//        result(NO, nil);
//        return;
//    }
    NSDictionary* dict = [self getRequestParaDic:method params:params];
    NSURLRequest *request = [self requestUnitWithSoapMethod:@"InvokeWS" Params:@{@"str":[GlobalMethod GlobalStringWithDictionary:dict]} Cookie:cookie];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                result(NO,nil);
            });
        }else{
            NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *resultJson = [self selectJsonFromXml:resultString];
            if (resultJson) {
                NSDictionary *dict = [self jsonSerialization:[resultJson dataUsingEncoding:NSUTF8StringEncoding]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(YES, dict);  // success
                });
                if (cookie) {       // should refresh cookie if the response has cookie
//                    [[LoginManager getInstance] refreshCookie];
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(NO, nil);    // json serialization error
                });
            }
        }
        
    }];
    [sessionDataTask resume];
}

- (NSURLRequest *)requestUnitWithSoapMethod:(NSString *)method Params:(NSDictionary *)params Cookie:(NSHTTPCookie *)cookie
{
    NSString *baseUrl;
    NSString *methodName;
    NSDictionary *paramsDic;
    
    baseUrl = BaseHeaderURL;
    methodName = method;
    paramsDic = params;
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    NSData *body = [self soap12BodyWithMethod:methodName andParams:paramsDic baseUrl:@"http://www.hepandai.com"];
    [request addValue:[@(body.length) stringValue] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    if (cookie) {
        //[self setCookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    return request;
}
//统一接口同步实现
- (BOOL)syncSoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(NSDictionary **)result
{
    NSDictionary* dict = [self getRequestParaDic:method params:params];
    NSURLRequest *request = [self requestWithSoapMethodSync:@"InvokeWS" Params:@{@"str":[GlobalMethod GlobalStringWithDictionary:dict]} Cookie:cookie];
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        *result = nil;
        return NO;      // connect error
    }
    else {
        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *resultJson = [self selectJsonFromXml:resultString];
        if (resultJson) {
            NSDictionary *dict = [self jsonSerialization:[resultJson dataUsingEncoding:NSUTF8StringEncoding]];
            if (dict[@"doObject"]) {
                [dict setValue:[[[RSA_AES_GZIP alloc] init] returndecryptStringtoString:dict[@"doObject"] andisEncrypt:[dict[@"isEncrypt"] boolValue] andisCompress:[dict[@"isCompress"] boolValue]] forKey:@"doObject"];
            }
            *result = dict;
            return YES;     // success
        }
        else {
            *result = nil;
            return NO;      // if json serialization error
        }
    }
    return YES;
}

- (NSURLRequest *)requestWithSoapMethodSync:(NSString *)method Params:(NSDictionary *)params Cookie:(NSHTTPCookie *)cookie
{
    NSString *baseUrl;
    NSString *methodName;
    NSDictionary *paramsDic;
    

    baseUrl = BaseHeaderURL;

    methodName = method;
    paramsDic = params;
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    NSData *body = [self soap12BodyWithMethod:methodName andParams:paramsDic baseUrl:@"http://www.hepandai.com"];
    [request addValue:[@(body.length) stringValue] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    if (cookie) {
        //[self setCookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    return request;
}
//webservice 异步统一方法
#pragma mark webservice 异步统一方法
-(void)webservicesAFNetPOSTMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result{

    NSDictionary* dict = [self getRequestParaDic:method params:params];
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    [session POST:BaseHeaderURL  parameters:@{@"str":[GlobalMethod GlobalStringWithDictionary:params]} success:^(NSURLSessionDataTask *task, id responseObject) {
   
        result(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (![self wasNetworkValid]) {
            HUD_TIP(@"网络繁忙，请稍后~");
    #if DEBUG
            NSLog(@"--->net work can not used!");
    #endif
            result(NO, nil);
            return;
        }
        result(NO,error);
    }];
}
-(AFHTTPSessionManager*)GetAFHTTPSessionManagerObject{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [session.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    return session;
}
//webservice 同步统一方法
#pragma mark webservice 同步统一方法
-(BOOL)webservicesyncSoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result
{
    NSDictionary* dict = [self getRequestParaDic:method params:params];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:BaseHeaderURL]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:8.0];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = [NSString stringWithFormat:@"str=%@",[GlobalMethod GlobalStringWithDictionary:dict]];//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    //第三步，连接服务器
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        result(NO,nil);
        HUD_TIP(@"网络繁忙，请稍后~");
        return NO;      // connect error
    }
    else {
        NSDictionary *dic = [self jsonSerialization:received];
        result(YES,dic);
        return YES;
    }
    return YES;
}


-(void)AFNetPOSTMethodWithUpload:(NSString *)method params:(NSDictionary*)params upData:(id)upData uptype:(NSInteger)uptype fileName:(NSString*)fileName cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result{
    NSDictionary* dict = [self getRequestParaDic:method params:params];
    AFHTTPSessionManager *manager = [self GetAFHTTPSessionManagerObject];
    NSDictionary *dict1 = @{@"str":[GlobalMethod GlobalStringWithDictionary:dict]};
    [manager POST:BaseHeaderURL parameters:dict1 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImagePNGRepresentation(upData);
        [formData appendPartWithFileData:data name:fileName fileName:fileName mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        result(YES,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        result(NO,error);
    }];
    
}
- (NSDictionary*)getRequestParaDic:(NSString *)method params:(NSDictionary *)params{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [USER_DEFAULT setObject:IOSVessionNumCode forKey:@"IOSVessionNum"];
    [dict setObject:method forKey:@"code"];
    [dict setObject:[MyTools getCurrentStandarTime] forKey:@"clienTime"];
    [dict setObject:[HDeviceIdentifier deviceIdentifier] forKey:@"deviceId"];
    NSLog(@"---%@",[HDeviceIdentifier deviceIdentifier]);
    [dict setObject:PLATFORM_COUNT forKey:@"platform"];
    NSString* clientDataStr = [USER_DEFAULT objectForKey:[NSString stringWithFormat:@"%@clientDataStr",method]];
    if (clientDataStr == nil) {
        clientDataStr = @"";
    }
    [dict setObject:clientDataStr forKey:@"clientDataMD5"];
    if (![BaseHeaderURL isEqualToString:newLocalHost]) {
        [dict setObject:@"true" forKey:@"isEncrypt"];
        [dict setObject:@"true" forKey:@"isCompress"];
    }else{
        [dict setObject:@"false" forKey:@"isEncrypt"];
        [dict setObject:@"false" forKey:@"isCompress"];
    }
    if (!params) {
        [dict setObject:@"" forKey:@"paramStr"];
        [dict setObject:@"" forKey:@"singnStr"];
    }else{
        NSString *returnStr = [[[RSA_AES_GZIP alloc] init] returnencryptStringtoString:[GlobalMethod GlobalStringWithDictionary:params]  andisEncrypt:dict[@"isEncrypt"] andisCompress:dict[@"isCompress"]];
        [dict setObject: returnStr forKey:@"paramStr"];
        [dict setObject:[GlobalMethod md5:[NSString stringWithFormat:@"%@HPD",returnStr]] forKey:@"singnStr"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@_%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"],[USER_DEFAULT objectForKey:@"IOSVessionNum"] ] forKey:@"version"];
    return dict;
}

- (NSDictionary *)getRequestDic:(NSDictionary *)params {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    [dict setObject:@"100" forKey:@"authCode"];
    [dict setObject:@"100" forKey:@"authUserId"];
    return dict;
}

- (void)PostNetRequestMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result {
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseHeaderURL,method];
    [session POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![self wasNetworkValid]) {
            HUD_TIP(@"网络繁忙，请稍后~");
#if DEBUG
            NSLog(@"--->net work can not used!");
#endif
            result(NO, nil);
            return;
        }
        result(NO,error);
    }];

    
}

- (void)GetNetRequestMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result {
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    
    [session GET:[NSString stringWithFormat:@"%@%@",BaseHeaderURL,method] parameters:@{@"str":[GlobalMethod GlobalStringWithDictionary:params]} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (![self wasNetworkValid]) {
            HUD_TIP(@"网络繁忙，请稍后~");
#if DEBUG
            NSLog(@"--->net work can not used!");
#endif
            result(NO, nil);
            return;
        }
        result(NO,error);
        
    }];
    
}
@end
