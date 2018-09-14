//
//  SY_ImageAndLabelBtn.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/16.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "SY_ImageAndLabelBtn.h"

@implementation SY_ImageAndLabelBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width / 2.0 - FITiPhone6(40), 0, FITiPhone6(80), FITiPhone6(80));
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, FITiPhone6(80), self.width, self.height-FITiPhone6(80));
}

@end
