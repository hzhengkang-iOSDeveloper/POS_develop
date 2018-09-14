//
//  CF_LeftNavigationBar_BackBtn.m
//  HpCF
//
//  Created by 孙亚男 on 2017/12/3.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "CF_LeftNavigationBar_BackBtn.h"

@implementation CF_LeftNavigationBar_BackBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(-FITiPhone6(15), (self.height-FITiPhone6(50))/2, FITiPhone6(50), FITiPhone6(50));
}

@end

