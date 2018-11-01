//
//  SettingTableViewCell.m
//  POS_develop
//
//  Created by syn on 2018/9/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SettingTableViewCell";
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = C000000;
    self.titleLabel.font = F13;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(25));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.iconImageV = [[UIImageView alloc] init];
    self.iconImageV.hidden = YES;
    [self addSubview:self.iconImageV];
    self.iconImageV.layer.cornerRadius = FITiPhone6(20);
    self.iconImageV.layer.masksToBounds = YES;
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(46), FITiPhone6(46)));
    }];
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    self.detailLabel.textColor = C000000;
    self.detailLabel.font = F13;
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-31));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    
    
}
@end
