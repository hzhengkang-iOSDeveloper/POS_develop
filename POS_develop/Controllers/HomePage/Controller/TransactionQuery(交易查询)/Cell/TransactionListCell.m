//
//  TransactionListCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionListCell.h"

@implementation TransactionListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TransactionListCell";
    TransactionListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TransactionListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = C000000;
    self.nameLabel.font = F13;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.snLabel = [[UILabel alloc] init];
    self.snLabel.textColor = C000000;
    self.snLabel.font = F12;
    self.snLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.snLabel];
    [self.snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(FITiPhone6(15));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = C989898;
    self.timeLabel.font = F10;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.snLabel.mas_bottom).offset(FITiPhone6(15));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.textColor = C000000;
    self.amountLabel.font = F15;
    self.amountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self.nameLabel.mas_top);
        make.height.mas_equalTo(FITiPhone6(14));
    }];
    self.seeDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seeDetail setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.seeDetail setTitleColor:C1E95F9 forState:UIControlStateNormal];
    self.seeDetail.titleLabel.font = F10;
    [self.seeDetail addTarget:self action:@selector(seeDetailClick) forControlEvents:UIControlEventTouchUpInside];
    self.seeDetail.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.seeDetail];
    [self.seeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(10));
    }];
}

- (void)seeDetailClick {
    if (self.seeDetailBlock) {
        self.seeDetailBlock();
    }
}
@end
