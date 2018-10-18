//
//  PD_BillSkuHeaderView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillSkuHeaderView.h"
#import "BillListModel.h"

@interface PD_BillSkuHeaderView ()
//状态view
@property (nonatomic, weak) UIView *billStatusView;
//日期
@property (nonatomic, weak) UILabel *dateLabel;
//订单状态
@property (nonatomic, weak) UILabel *billStatusLabel;

@end
@implementation PD_BillSkuHeaderView

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
    
    //状态view
    UIView *billStatusView = [UIView new];
    billStatusView.backgroundColor = WhiteColor;
    [self addSubview:billStatusView];
    self.billStatusView  = billStatusView;
    [_billStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(AD_HEIGHT(5));
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(36)));
    }];
    
    
    //日期
    UILabel *dateLabel = [UILabel new];
//    dateLabel.text = @"2017.08.21";
    dateLabel.textColor = C000000;
    dateLabel.font = F13;
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.billStatusView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(AD_HEIGHT(16));
    }];
    
    
    //订单状态
    UILabel *billStatusLabel = [UILabel new];
//    billStatusLabel.text = @"待发货";
    billStatusLabel.textColor = C000000;
    billStatusLabel.font = F13;
    billStatusLabel.textAlignment = NSTextAlignmentRight;
    [self.billStatusView addSubview:billStatusLabel];
    self.billStatusLabel = billStatusLabel;
    [_billStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-AD_HEIGHT(16));
    }];
    
    //line
    UIView *lineView = [UIView new];
    lineView.backgroundColor = CE6E2E2;
    [self.billStatusView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.bottom.offset(0);
    }];
}
- (void)setModel:(BillListModel *)model {
    if (model) {
        _model = model;
        self.dateLabel.text = [model.createtime substringToIndex:10];
        if ([model.orderStatus isEqualToString:@"10"]) {
            self.billStatusLabel.text = @"待付款";
        }else if ([model.orderStatus isEqualToString:@"20"]) {
            self.billStatusLabel.text = @"待发货";
        }else if ([model.orderStatus isEqualToString:@"30"]) {
            self.billStatusLabel.text = @"待确认";
        }else {
            self.billStatusLabel.text = @"已完成";
        }
        
    }
}
@end
