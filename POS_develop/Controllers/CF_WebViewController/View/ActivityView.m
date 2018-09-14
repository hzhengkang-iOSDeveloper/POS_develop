//
//  ActivityView.m
//  HePanDai2_0
//
//  Created by 合盘贷 on 16/2/25.
//  Copyright © 2016年 HePanDai. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

+ (ActivityView *)instancView
{
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"ActivityView" owner:self options:nil];
    return arr[0];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

@end
