//
//  PD_BillListCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListCell.h"
@interface PD_BillListCell ()
//状态view
@property (nonatomic, weak) UIView *billStatusView;
//日期
@property (nonatomic, weak) UILabel *dateLabel;
//订单状态
@property (nonatomic, weak) UILabel *billStatusLabel;


//sku List
@property (nonatomic, weak) UITableView *skuListTable;
//底部view
@property (nonatomic, weak) UIView *bottomView;
@end
@implementation PD_BillListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillListCell";
    PD_BillListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = CF6F6F6;
    
    //状态view
    UIView *billStatusView = [UIView new];
    billStatusView.backgroundColor = WhiteColor;
    [self.contentView addSubview:billStatusView];
    self.billStatusView  = billStatusView;
    [_billStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(36)));
    }];
    
   //日期
    UILabel *dateLabel = [UILabel new];
    dateLabel.textColor = C000000;
    dateLabel.font = MainFont(AD_HEIGHT(13));
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.billStatusView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(AD_HEIGHT(16));
    }];
    
    
    //订单状态
    UILabel *billStatusLabel = [UILabel new];
    billStatusLabel.textColor = C000000;
    billStatusLabel.font = MainFont(AD_HEIGHT(13));
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
@end
