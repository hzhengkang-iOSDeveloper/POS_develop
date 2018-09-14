//
//  UIAlertView+Blocks.h
//  ForbiddenCityVirtual_EN
//
//  Created by Heramerom on 13-7-12.
//  Copyright (c) 2013年 Duke Douglas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Blocks) <UIAlertViewDelegate>

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title
                                message:(NSString*) message
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed
                               onCancel:(CancelBlock) cancelled;

+ (void) showMessage:(NSString*) message;

+ (void) showMessage:(NSString *)msg withCancle:(CancelBlock)cancle;


@end
