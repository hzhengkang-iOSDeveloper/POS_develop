//
//  MBProgressHUD+Count.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MBProgressHUD+Count.h"
#import <objc/runtime.h>

static const char MBProgressHUD_ShowCount_Key = '\0';
@implementation MBProgressHUD (Count)
- (void)setShowCount:(NSInteger)showCount
{
    NSNumber *showConutNumber = [NSNumber numberWithInteger:showCount];
    [self willChangeValueForKey:@"showCount"];
    objc_setAssociatedObject(self, &MBProgressHUD_ShowCount_Key, showConutNumber, OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)showCount
{
    NSNumber *showCountNumber = objc_getAssociatedObject(self, &MBProgressHUD_ShowCount_Key);
    return showCountNumber.integerValue;
}
@end
