//
//  MyBillTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyBillTableViewCell.h"

@implementation MyBillTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"MyBillTableViewCell";
    MyBillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyBillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = C000000;
    self.contentLabel.font = F13;
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(18));
        make.height.mas_equalTo(FITiPhone6(14));
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = C989898;
    self.timeLabel.font = F10;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.contentLabel.mas_bottom).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.textColor = C000000;
    self.amountLabel.font = F13;
    self.amountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self).offset(FITiPhone6(10));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.totalAmountLabel = [[UILabel alloc] init];
    self.totalAmountLabel.textColor = C000000;
    self.totalAmountLabel.font = F12;
    self.totalAmountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalAmountLabel];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.bottom.equalTo(self).offset(FITiPhone6(-14));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = CE6E2E2;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(0.5)));
    }];
}
@end















