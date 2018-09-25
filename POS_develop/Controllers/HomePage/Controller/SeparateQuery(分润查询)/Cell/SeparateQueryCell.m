//
//  SeparateQueryCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryCell.h"

@implementation SeparateQueryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SeparateQueryCell";
    SeparateQueryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SeparateQueryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI{
    self.contentView.backgroundColor = WhiteColor;
    
    
    
    self.totalAmount = [[UILabel alloc] init];
    self.totalAmount.text = @"总金额:59072938749.01";
    self.totalAmount.textAlignment = NSTextAlignmentLeft;
    self.totalAmount.textColor = C000000;
    self.totalAmount.font = F13;
    [self.contentView addSubview:self.totalAmount];
    [self.totalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(FITiPhone6(15));
        make.top.offset(FITiPhone6(17));
    }];
    
    
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"高棉闪电发货";
    self.name.textAlignment = NSTextAlignmentRight;
    self.name.textColor = C000000;
    self.name.font = F13;
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-FITiPhone6(15));
        make.top.offset(FITiPhone6(17));
    }];



    self.time = [[UILabel alloc] init];
    self.time.textAlignment = NSTextAlignmentLeft;
    self.time.text = @"交易日期2018/09/19-2019/08/12";
    self.time.textColor = C989898;
    self.time.font = F10;
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(FITiPhone6(15));
        make.top.equalTo(self.totalAmount.mas_bottom).offset(FITiPhone6(11));
    }];


    self.totalPenNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalPenNumber.userInteractionEnabled = NO;
    [self.totalPenNumber setTitle:@"总笔数:98" forState:UIControlStateNormal];
    [self.totalPenNumber setTitleColor:C989898 forState:UIControlStateNormal];
    [self.totalPenNumber layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(8)];
    [self.totalPenNumber setImage:[UIImage imageNamed:@"总笔数"] forState:normal];
    self.totalPenNumber.titleLabel.font = F10;
    self.totalPenNumber.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.totalPenNumber];
    [self.totalPenNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(FITiPhone6(15));
        make.top.equalTo(self.time.mas_bottom).offset(FITiPhone6(11));
        make.height.mas_offset(FITiPhone6(13));
    }];


    self.totalShareProfit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalShareProfit.userInteractionEnabled = NO;
    [self.totalShareProfit setTitle:@"总分润:5000.06元" forState:UIControlStateNormal];
    [self.totalShareProfit setTitleColor:C000000 forState:UIControlStateNormal];
    [self.totalShareProfit layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(8)];
    [self.totalShareProfit setImage:[UIImage imageNamed:@"总分润"] forState:normal];
    self.totalShareProfit.titleLabel.font = F12;
    self.totalShareProfit.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.totalShareProfit];
    [self.totalShareProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(FITiPhone6(-15));
        make.top.equalTo(self.totalPenNumber.mas_top);
        make.height.mas_offset(FITiPhone6(13));
    }];

    [UIView getViewWithColor:CF6F6F6 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
}
@end
