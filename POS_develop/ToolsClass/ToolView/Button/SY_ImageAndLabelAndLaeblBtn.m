//
//  SY_ImageAndLabelAndLaeblBtn.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/18.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "SY_ImageAndLabelAndLaeblBtn.h"

@implementation SY_ImageAndLabelAndLaeblBtn


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width / 2.0 - FITiPhone6(60), 0, FITiPhone6(120), FITiPhone6(120));
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, FITiPhone6(120), self.width, self.height-FITiPhone6(130));
}

//- (CGRect)explainTitleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, FITiPhone6(169), self.width, FITiPhone6(33));
//}
@end
