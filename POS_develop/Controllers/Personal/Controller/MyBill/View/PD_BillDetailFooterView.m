//
//  PD_BillDetailFooterView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailFooterView.h"
@interface PD_BillDetailFooterView ()
@property (nonatomic, weak) UILabel *discountPriceLabel;//优惠价格
@property (nonatomic, weak) UILabel *totalPriceLabel;//总价
@property (nonatomic, weak) UILabel *totalCountLabel;//总数
@end
@implementation PD_BillDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    self.backgroundColor = WhiteColor;
    MJWeakSelf;
    
    //优惠价格
    UILabel *discountPriceLabel = [UILabel getLabelWithFont:F13 textColor:CF52542 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = @"￥230";
    }];
    self.discountPriceLabel = discountPriceLabel;
    
    //总价
    UILabel *totalPriceLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.discountPriceLabel.mas_right).offset(AD_HEIGHT(27));
        make.centerY.offset(0);
        
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"￥560.00" attributes:attribtDic];
        // 赋值
        view.attributedText = attribtStr;
    }];
    self.totalPriceLabel = totalPriceLabel;
    
    
    //总数
    UILabel *totalCountLabel = [UILabel getLabelWithFont:F15 textColor:C000000 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = @"x2";
    }];
    self.totalCountLabel = totalCountLabel;
}

@end
