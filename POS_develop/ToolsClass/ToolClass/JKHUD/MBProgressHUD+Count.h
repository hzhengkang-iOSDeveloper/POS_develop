//
//  MBProgressHUD+Count.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//
/**
 *  处理一个界面多次请求的多次显示及隐藏问题
 */
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Count)
/**
 *  当前view被显示的次数
 */
@property (nonatomic,assign)NSInteger showCount;
@end

NS_ASSUME_NONNULL_END
