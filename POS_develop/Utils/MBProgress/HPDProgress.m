//
//  HPDProgress.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-6.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "HPDProgress.h"

@implementation HPDProgress

+ (HPDProgress *)defaultProgressHUD
{
    static HPDProgress *progress = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progress  = [[HPDProgress alloc] init];
    });
    return progress;
}
- (void)showHUDOnView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)delay complete:(HideComplateBlock)block{
    [self showHUDOnView:view message:message];
    [self hideAfterDelay:delay complete:block];
}
- (void)showHUDOnView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)delay
{
    [self showHUDOnView:view message:message];
    [self hideAfterDelay:delay];
}

- (void)showHUDOnView:(UIView *)view message:(NSString *)message
{
    _progressHud = [[MBProgressHUD alloc] initWithView:view];
    _progressHud.mode = MBProgressHUDModeIndeterminate;
    _progressHud.labelText = message;
    _progressHud.removeFromSuperViewOnHide = YES;
    [view addSubview:_progressHud];
    [_progressHud show:YES];
}

- (void)showCoustomOnView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)delay complete:(HideComplateBlock)block
{
    [self showCoustomOnView:view message:message];
    [self hideAfterDelay:delay complete:block];
}

#pragma mark -- 只有文字没有图片
- (void)showSimpleViewOnView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)delay complete:(HideComplateBlock)block
{
    [self showSimpleViewOnView:view message:message];
    [self hideAfterDelay:delay complete:block];
}
- (void)showCoustomOnView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)delay
{
    [self showCoustomOnView:view message:message];
    [self hideAfterDelay:delay];
}
- (void)showSimpleViewOnView:(UIView *)view message:(NSString *)message
{
        _progressHud = [[MBProgressHUD alloc] initWithView:view];
        _progressHud.mode = MBProgressHUDModeCustomView;
        _progressHud.labelText = message;
        _progressHud.removeFromSuperViewOnHide = YES;
        [view addSubview:_progressHud];
        [_progressHud show:YES];
}
- (void)showCoustomOnView:(UIView *)view message:(NSString *)message
{
//    _progressHud = [[MBProgressHUD alloc] initWithView:view];
//    _progressHud.mode = MBProgressHUDModeCustomView;
//    _progressHud.labelText = message;
//    _progressHud.removeFromSuperViewOnHide = YES;
//    [view addSubview:_progressHud];
//    [_progressHud show:YES];
    
    _progressHud = [[MBProgressHUD alloc] initWithView:view];
    _progressHud.mode = MBProgressHUDModeCustomView;
    _progressHud.labelText = message;
    _progressHud.removeFromSuperViewOnHide = YES;
    [view addSubview:_progressHud];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=21; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"02帧-%ld", i]];
        [refreshingImages addObject:image];
    }
    UIImage *image = [[UIImage imageNamed:@"02帧-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.animationImages = refreshingImages;
    [imgView setAnimationDuration:1.0f];
    [imgView setAnimationRepeatCount:0];
    [imgView startAnimating];
    _progressHud.customView = imgView;
    _progressHud.animationType = MBProgressHUDAnimationFade;
    [_progressHud show:YES];
}

- (void)holdMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay complete:(HideComplateBlock)complete
{
    [self holdMessage:message];
    [self hideAfterDelay:delay complete:complete];
}

- (void)holdMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay
{
    [self holdMessage:message];
    [self hideAfterDelay:delay];
}

- (void)holdMessage:(NSString *)message
{
    _progressHud = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication]keyWindow]];
    _progressHud.mode = MBProgressHUDModeText;
    _progressHud.labelText = message;
    _progressHud.removeFromSuperViewOnHide = YES;
    [[[UIApplication sharedApplication]keyWindow] addSubview:_progressHud];
    [_progressHud show:YES];
}

- (void)hide
{
    [_progressHud hide:YES];
}
- (void)hideAfterDelay:(NSTimeInterval)delay
{
    [_progressHud hide:YES afterDelay:delay];
}

- (void)hideAfterDelay:(NSTimeInterval)delay complete:(HideComplateBlock)complete
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
        complete();
    });
}


@end
