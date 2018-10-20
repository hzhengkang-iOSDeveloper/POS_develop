//
//  TransactionQueryMainView.m
//  POS_develop
//
//  Created by syn on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionQueryMainView.h"


@interface TransactionQueryMainView ()

@end
@implementation TransactionQueryMainView
- (IBAction)BrandSelectionBtnClick:(id)sender {
    NSString *titleStr = @"请选择";
//    NSArray *nameArray = [NSMutableArray arrayWithObjects:@"不限",@"新国都",@"华智慧",@"新大陆", nil];
    SheetPickerView *pickerView = [SheetPickerView SheetStringPickerWithTitle:self.posBrandNameArr andHeadTitle:titleStr withIsDatePicker:NO Andcall:^(SheetPickerView *pickerView, NSString *choiceString) {
        [pickerView dismissPicker];
        
        if (self.brandBlock) {
            self.brandBlock(choiceString);
        }
    }];
    [pickerView show];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查询条件(非必填)"];
    [str addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(4,str.length - 4)];
    self.conditionLabel.attributedText = str;
}


//- (void)setPosBrandNameArr:(NSMutableArray *)posBrandNameArr {
//    if (posBrandNameArr) {
//        _posBrandNameArr = posBrandNameArr;
//        
//        [self layoutSubviews];
//    }
//}

@end













