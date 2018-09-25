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
    self.totalAmount = [[UILabel alloc] init];
    self.totalAmount.textColor = C000000;
    self.totalAmount.font = F13;
    self.totalAmount.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalAmount];
    [self.totalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.name = [[UILabel alloc] init];
    self.name.textColor = C000000;
    self.name.font = F13;
    self.name.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.time = [[UILabel alloc] init];
    self.time.textColor = C989898;
    self.time.font = F10;
    self.time.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalAmount];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.totalAmount.mas_bottom).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.totalPenNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.totalPenNumber setTitle:@"总笔数:98" forState:UIControlStateNormal];
    [self.totalPenNumber setTitleColor:C989898 forState:UIControlStateNormal];
    [self.totalPenNumber layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(8)];
    [self.totalPenNumber setImage:[UIImage imageNamed:@"总笔数"] forState:normal];
    self.totalPenNumber.titleLabel.font = F10;
    self.totalPenNumber.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalPenNumber];
    [self.totalPenNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.time.mas_bottom).offset(FITiPhone6(11));
        make.height.mas_offset(FITiPhone6(13));
    }];
    self.totalShareProfit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.totalShareProfit setTitle:@"总分润:5000.06元" forState:UIControlStateNormal];
    [self.totalShareProfit setTitleColor:C000000 forState:UIControlStateNormal];
    [self.totalShareProfit layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(8)];
    [self.totalShareProfit setImage:[UIImage imageNamed:@"总分润"] forState:normal];
    self.totalShareProfit.titleLabel.font = F12;
    self.totalShareProfit.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalShareProfit];
    [self.totalShareProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self.totalPenNumber.mas_top);
        make.height.mas_offset(FITiPhone6(13));
    }];
    
}
@end
