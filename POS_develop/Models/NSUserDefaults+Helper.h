//
//  NSUserDefaults+Helper.h
//  HpCF
//
//  Created by 孙亚男 on 2017/10/10.
//  Copyright © 2017年 孙亚男. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)
/*保存用户登录状态*/
@property(nonatomic)BOOL isLenit;

/* 是否第一次进入 */
@property (nonatomic) BOOL didAccess;

/* 是否实名认证 */
@property (nonatomic) BOOL iS_RealAuthentication;

/* 是否绑定银行卡 */
@property (nonatomic) BOOL iS_BindCard;

/**
 *  退出登录后清空相关信息
 */
- (void)clear;

@end
