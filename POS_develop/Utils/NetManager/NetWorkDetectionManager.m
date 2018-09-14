/**
 * Create Author : lvy
 * Create Date   : 13-4-11
 * File Name     : NetWorkDetection.m
 *
 * Copyright (c) 2011-2014 by Shanghai k-net Information Co. Ltd
 * All rights reserved
 */

#import "NetWorkDetectionManager.h"
/**
 *  网络检测
 */
@implementation NetWorkDetectionManager
{
    /** 表示是否已经在侦测网络状况 */
    BOOL isDetecting;
    
    /** a instance of Reachability */
    __strong Reachability *hostReach;
    
    /** a boolean value indicate whether the network is available */
    BOOL isNetworkReachable;
}

/** override */
- (id)init
{
    if (self = [super init]) {
        isDetecting = NO;
    }
    
    return self;
}

/** 单例方法 */
+ (id)defaultNetWorkDetection
{
    static id netWorkDetection = nil;
    
    if (netWorkDetection == nil) {
        netWorkDetection = [[NetWorkDetectionManager alloc] init];
    }
    
    return netWorkDetection;
}

/** 开始监听网络状态 */
- (void)startDetectingTheNetWork
{
    if (isDetecting == YES) {
        return;
    }
    
    /*开启网络状况监听*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    isNetworkReachable = [self isNetworkAvailable];
    [hostReach startNotifier];
    isDetecting = YES;
}

/** 网络状况变化时回调此方法 */
- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *currentReach = [notification object];
    
    //    NSParameterAssert([currentReach isKindOfClass:[Reachability class]]);
    if (![currentReach isKindOfClass:[Reachability class]]) {
        return;
    }
    
    NetworkStatus status = [currentReach currentReachabilityStatus];
    if (status == NotReachable) {
        isNetworkReachable = NO;
    } else {
        isNetworkReachable = YES;
    }
}

/** 第一次检测网络状况的方法 */
- (BOOL)isNetworkAvailable
{
    if (hostReach.currentReachabilityStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

/** 返回一个标识当前网络是否可用的布尔值 */
- (BOOL)isNetworkReachable
{
    return isNetworkReachable;
}



@end

