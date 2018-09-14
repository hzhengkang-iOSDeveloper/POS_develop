//
//  StaticLibrary.h
//  StaticLibrary
//
//  Created by 合盘贷 on 16/5/17.
//  Copyright © 2016年 HePanDai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticLibrary : NSObject
//验证bundleID
- (void)CheckIdentifier;

//获取服务器授权字符串
- (NSString *)getAppRequestIdentifier;
@end
