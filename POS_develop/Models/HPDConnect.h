//
//  HPDConnect.h
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^AFNetRequestResultBlock)(bool success, id result);
typedef void(^HPDRequestResultBlock)(bool success, NSDictionary *result);

@interface HPDConnect : NSObject



+ (HPDConnect *)connect;
- (BOOL)wasNetworkValid;

/**
 *  异步 soap 请求  带有cookie参数
 *
 *  @param method soap方法
 *  @param params 请求参数
 *  @param cookie cookie 可以为nil
 *  @param result 请求结果
 */
- (void)ansySoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(HPDRequestResultBlock)result;

- (void)ansySoapMethod:(NSString *)method params:(NSDictionary *)params result:(HPDRequestResultBlock)result;

/**
 *  同步 soap 请求 带有cookie参数
 *
 *  @param method soap 方法
 *  @param params 请求用的参数
 *  @param cookie 请求用的 cookie 可以为nil
 *  @param dict   返回的内容放到字典中
 *
 *  @return 是否成功
 */
- (BOOL)syncSoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(NSDictionary **)dict;
//统一接口
- (void)ansySoapUintMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(HPDRequestResultBlock)result;
//webservice 异步统一方法
-(void)webservicesAFNetPOSTMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result;
//webservice 同步统一方法
-(BOOL)webservicesyncSoapMethod:(NSString *)method params:(NSDictionary *)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result;


/**
 *  上传文件
 *
 *  @param method 接口名
 *  @param params 参数
 *  @param upData 上传的文件
 *  @param uptype 类型 0-图片 1-text文本
 *  @param cookie cooking
 *  @param result 返回结果
 */
-(void)AFNetPOSTMethodWithUpload:(NSString *)method params:(NSDictionary*)params upData:(id)upData uptype:(NSInteger)uptype fileName:(NSString*)fileName cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result;




- (void)PostNetRequestMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result;


- (void)GetNetRequestMethod:(NSString *)method params:(NSDictionary*)params cookie:(NSHTTPCookie *)cookie result:(AFNetRequestResultBlock)result;
@end
