//
//  TransactionDetailCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionDetailCell.h"

@implementation TransactionDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TransactionDetailCell";
    TransactionDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TransactionDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = C000000;
    self.titleLabel.font = F13;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = C989898;
    self.timeLabel.font = F10;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(FITiPhone6(7));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.textColor = C000000;
    self.amountLabel.font = F13;
    self.amountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self.titleLabel.mas_top);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textColor = C989898;
    self.statusLabel.font = F12;
    self.statusLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self.timeLabel.mas_top);
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    
}

@end
