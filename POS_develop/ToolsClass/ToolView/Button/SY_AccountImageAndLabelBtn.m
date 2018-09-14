//
//  SY_AccountImageAndLabelBtn.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/19.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "SY_AccountImageAndLabelBtn.h"

@implementation SY_AccountImageAndLabelBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, FITiPhone6(56), FITiPhone6(56));
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(FITiPhone6(69), 0, self.width-FITiPhone6(69), self.height);
}

@end
