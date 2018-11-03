//
//  SYShowHUD.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYShowHUD : NSObject
+ (SYShowHUD *)shared;


/**
 *  显示等待菊花
 */
+ (void)showWait;

/**
 *  显示无背景等待菊花
 */
+ (void)showNoBgWaitWith:(BOOL)isTouch;

/**
 *  隐藏等待菊花
 */
+ (void)hideWait;


/**
 *  显示信息
 *
 *  @param text 信息内容
 */
+ (void)showTip:(NSString *)text;



/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success;


/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
