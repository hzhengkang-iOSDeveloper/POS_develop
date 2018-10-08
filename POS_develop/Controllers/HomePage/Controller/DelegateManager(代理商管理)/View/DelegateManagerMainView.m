//
//  DelegateManagerMainView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "DelegateManagerMainView.h"

@implementation DelegateManagerMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查询条件(非必填)"];
    [str addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(4,str.length - 4)];
    self.conditionLabel.attributedText = str;
}
@end
