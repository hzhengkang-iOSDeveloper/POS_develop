//
//  SeparateQueryMainView.m
//  POS_develop
//
//  Created by syn on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryMainView.h"

@implementation SeparateQueryMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查询条件(非必填)"];
    [str addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(4,str.length - 4)];
    self.conditionLabel.attributedText = str;
}

@end
