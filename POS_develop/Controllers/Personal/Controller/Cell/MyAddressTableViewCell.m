//
//  MyAddressTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyAddressTableViewCell.h"

@implementation MyAddressTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"MyAddressTableViewCell";
    MyAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = C090909;
    self.nameLabel.font = F13;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(25));
        make.top.equalTo(self).offset(FITiPhone6(12));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textColor = C989898;
    self.addressLabel.font = F12;
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(FITiPhone6(10));
        make.height.mas_equalTo(FITiPhone6(12));
    }];
    self.telephoneLabel = [[UILabel alloc] init];
    self.telephoneLabel.textColor = C090909;
    self.telephoneLabel.font = F13;
    self.telephoneLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.telephoneLabel];
    [self.telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-25));
        make.top.equalTo(self.nameLabel.mas_top);
        make.height.mas_equalTo(FITiPhone6(12));
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = CE6E2E2;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.addressLabel.mas_bottom).offset(FITiPhone6(21));
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(0.5)));
    }];
    self.defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [self.defaultAddressBtn setTitleColor:C090909 forState:UIControlStateNormal];
    [self.defaultAddressBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(13)];
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认"] forState:normal];
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认地址"] forState:UIControlStateSelected];
    [self.defaultAddressBtn addTarget:self action:@selector(defaultAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    self.defaultAddressBtn.titleLabel.font = F12;
    [self addSubview:self.defaultAddressBtn];
    [self.defaultAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(25));
        make.bottom.equalTo(self).offset(FITiPhone6(-15));
        make.size.sizeOffset(CGSizeMake(FITiPhone6(80), FITiPhone6(15)));
    }];
    self.deleteAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteAddressBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteAddressBtn setTitleColor:C090909 forState:UIControlStateNormal];
    [self.deleteAddressBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(5)];
    [self.deleteAddressBtn setImage:[UIImage imageNamed:@"删除"] forState:normal];
    [self.deleteAddressBtn addTarget:self action:@selector(deleteAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteAddressBtn.titleLabel.font = F12;
    self.deleteAddressBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.deleteAddressBtn];
    [self.deleteAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-25));
        make.bottom.equalTo(self).offset(FITiPhone6(-14));
        make.height.mas_offset(FITiPhone6(15));
    }];
    self.editAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editAddressBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editAddressBtn setTitleColor:C090909 forState:UIControlStateNormal];
    [self.editAddressBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(5)];
    [self.editAddressBtn setImage:[UIImage imageNamed:@"编辑"] forState:normal];
    [self.editAddressBtn addTarget:self action:@selector(editAddresClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editAddressBtn.titleLabel.font = F12;
    self.editAddressBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.editAddressBtn];
    [self.editAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteAddressBtn.mas_left).offset(FITiPhone6(-40));
        make.bottom.equalTo(self.deleteAddressBtn.mas_bottom);
        make.height.mas_offset(FITiPhone6(15));
    }];
}

#pragma mark ---- 默认地址 ----
- (void)defaultAddressClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark ---- 编辑 ----
- (void)editAddresClick:(UIButton *)sender {
    
}
#pragma mark ---- 删除 ----
- (void)deleteAddressClick:(UIButton *)sender {
    
}




@end
