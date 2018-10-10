//
//  SYShowHUD.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SYShowHUD.h"

@implementation SYShowHUD
static SYShowHUD *_showHUD;

+ (SYShowHUD *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showHUD = [[SYShowHUD alloc] init];
    });
    return _showHUD;
}

/**
 *  显示信息
 *
 *  @param text 信息内容
 */
+ (void)showTip:(NSString *)text
{
    text = [NSString removeEmpty:text];
    if ([text isEqual:[NSNull null]] || text == nil) {
        if (!([text isKindOfClass:[NSString class]] && text.length > 0)) {
            return;
        }
    }
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:text];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom]; //设置HUD背景图层的样式
    [SVProgressHUD dismissWithDelay:1.8];
    
}



/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [SVProgressHUD showSuccessWithStatus:success];
    [SVProgressHUD dismissWithDelay:1.8];
    
}



/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    
    [SVProgressHUD showErrorWithStatus:error];
    [SVProgressHUD dismissWithDelay:1.8];
}


@end
