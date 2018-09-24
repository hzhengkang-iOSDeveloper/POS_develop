//
//  PD_BillDetailHeaderView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailHeaderView.h"
@interface PD_BillDetailHeaderView ()
@property (nonatomic, weak) UILabel *topTitleLabel;
@property (nonatomic, weak) UILabel *storeNameLabel;

@end
@implementation PD_BillDetailHeaderView

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
    self.backgroundColor = CF6F6F6;
    
    MJWeakSelf;
    UILabel *topTitleLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(16));
        make.top.offset(AD_HEIGHT(8));
        
        view.text = @"套餐";
    }];
    self.topTitleLabel = topTitleLabel;
    
    UIView *bottomView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(weakSelf.topTitleLabel.mas_bottom).offset(AD_HEIGHT(8));
        make.bottom.offset(0);
        make.right.offset(0);
        
    }];
    
    UILabel * storeNameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = @"双喜临门套餐";
    }];
    self.storeNameLabel = storeNameLabel;
}

@end
