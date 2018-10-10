//
//  SVProgressHUD+Extension.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/26.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SVProgressHUD+Extension.h"

@implementation SVProgressHUD (Extension)
+ (void)load {
    [super load];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor clearColor]];

}
@end
