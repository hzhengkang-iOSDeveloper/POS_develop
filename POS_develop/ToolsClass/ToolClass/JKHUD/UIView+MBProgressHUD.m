//
//  UIView+MBProgressHUD.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import "MBProgressHUD+Count.h"
#import "NSString+Drawing.h"
#import "ToastView.h"

@implementation UIView (MBProgressHUD)
//- (void)showWaiting
//{
//    [self showWaiting:NO];
//}
//
//- (void)showWaiting:(BOOL)userInteraction
//{
//    [self showWaiting:userInteraction message:nil];
//}
//
//- (void)showWaiting:(BOOL)userInteractiion message:(NSString *)message
//{
//    [self showWaiting:userInteractiion message:message delay:MAXFLOAT];
//}
//
//- (void)showWaiting:(BOOL)userInteractiion message:(NSString *)message delay:(float)seconds
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
//        if (!hud) {
//            hud = [[MBProgressHUD alloc] initWithView:self];
//        }
//        hud.showCount ++;
//        hud.label.text = message;
//        hud.removeFromSuperViewOnHide = YES;
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//        hud.bezelView.backgroundColor = [UIColor clearColor]; //背景色
//        hud.userInteractionEnabled = !userInteractiion;
//        [self addSubview:hud];
//        [hud showAnimated:YES];
//        [hud hideAnimated:YES afterDelay:seconds];
//    });
//    
//}
//
//- (void)showGif
//{
//    [self showGif:NO];
//}
//
//- (void)showGif:(BOOL)userInteractiion
//{
//    NSArray *imageNames = @[@"hud_loading801",@"hud_loading802",@"hud_loading803"];
//    NSMutableArray *images = [NSMutableArray array];
//    for (NSString *imageName in imageNames)
//    {
//        UIImage *image = [UIImage imageNamed:imageName];
//        [images addObject:image];
//    }
//    
//    UIImageView *imageView = [[UIImageView alloc]init];
//    UIImage *image = [images firstObject];
//    imageView.image = image;
//    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.width);
//    imageView.animationImages = images;
//    imageView.animationDuration = 1;
//    imageView.animationRepeatCount = 0;
//    [imageView startAnimating];
//    [self showCustomView:imageView userInteractiion:userInteractiion];
//}
//
//- (void)showToast:(NSString *)text
//{
//    int strCount = (int)text.length;
//    CGFloat time = 1;
//    if (strCount < 5) {
//        time = 1;
//    }else if (strCount < 10) {
//        time = 1.7;
//    }else if (strCount < 15) {
//        time = 2.7;
//    }else if (strCount < 20) {
//        time = 3.7;
//    }else if (strCount < 25) {
//        time = 4.7;
//    }else {
//        time = 5.7;
//    }
//    [self showToast:text delay:time];
//}
//
//- (void)showToast:(NSString *)text delay:(float)second
//{
//    text = [NSString removeEmpty:text];
//    [self hiddenWaitingImmediately];
//    if (text.length == 0) {
//        return;
//    }
//    ToastView *view = [[ToastView alloc] initWithText:text];
//    MBProgressHUD *hud  = [self showCustomView:view userInteractiion:NO];
//    hud.userInteractionEnabled = NO;
//    [hud hideAnimated:YES afterDelay:second];
//}
//
//- (void)hiddenWaitingImmediately
//{
//    MBProgressHUD * hud = [MBProgressHUD HUDForView:self];
//    hud.showCount = 0;
//    [MBProgressHUD hideHUDForView:self animated:NO];
//}
//
//- (void)hiddenWaiting
//{
//    MBProgressHUD * hud = [MBProgressHUD HUDForView:self];
//    hud.showCount = 0;
//    [MBProgressHUD hideHUDForView:self animated:YES];
//}
//
//- (void)hiddenWaitingForTransaction
//{
//    MBProgressHUD * hud = [MBProgressHUD HUDForView:self];
//    hud.showCount--;
//    if(hud.showCount <= 0)
//    {
//        [self hiddenWaitingImmediately];
//    }
//}
//
//- (MBProgressHUD *)showCustomView:(UIView *)view userInteractiion:(BOOL)userInteractiion
//{
//    MBProgressHUD * hud = [MBProgressHUD HUDForView:self];
//    if (!hud)
//    {
//        hud = [[MBProgressHUD alloc]initWithView:self];
//    }
//    hud.showCount ++;
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.customView = view;
//    hud.removeFromSuperViewOnHide = YES;
//    hud.margin = 0;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor clearColor];
//    hud.userInteractionEnabled = !userInteractiion;
//    [self addSubview:hud];
//    [hud showAnimated:YES];
//    return hud;
//}

@end
