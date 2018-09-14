/**
 * Create Author : lvy
 * Create Date   : 13-4-11
 * File Name     : NetWorkDetection.h
 *
 * Copyright (c) 2011-2014 by Shanghai k-net Information Co. Ltd
 * All rights reserved
 */

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define kIsNetWorkReachable [[NetWorkDetectionManager defaultNetWorkDetection] isNetworkReachable]

/**
 *  检测网络
 */
@interface NetWorkDetectionManager : NSObject


/**
 * @description：单例方法
 *
 * @author:zyh
 *
 * @param: nil
 *
 * @return 一个NetWorkDetection实例
 */
+ (id)defaultNetWorkDetection;

/**
 * @description：开始监听网络状况
 *
 * @author:zyh
 *
 * @param: nil
 *
 */
- (void)startDetectingTheNetWork;

/**
 * @description:判断当前网络是否可用
 *
 * @author: zyh
 *
 * @param: nil
 *
 * @return 一个标识当前网络是否可用的布尔值
 */
- (BOOL)isNetworkReachable;

@end

