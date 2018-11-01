//
//  MyAddressTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyAddressTableViewCell.h"
#import "MyAddressViewModel.h"
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
    self.nameLabel.textColor = C000000;
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
    self.telephoneLabel.textColor = C000000;
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
    [self.defaultAddressBtn setTitleColor:C000000 forState:UIControlStateNormal];
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
    [self.deleteAddressBtn setTitleColor:C000000 forState:UIControlStateNormal];
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
    [self.editAddressBtn setTitleColor:C000000 forState:UIControlStateNormal];
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
    
    HUD_NOBGSHOW;
    
    LoginManager *manager = [LoginManager getInstance];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/address/update" params:@{@"userid":IF_NULL_TO_STRING(manager.userInfo.userId), @"defaultFlag":[self.addressM.defaultFlag isEqualToString:@"0"]?@"1":@"0", @"id":self.addressM.ID} cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                sender.selected = !sender.selected;
                if (sender.selected ) {
                    self.addressM.defaultFlag = @"0";
                } else {
                    self.addressM.defaultFlag = @"1";
                }
                if (self.clickDefaultAddBlock) {
                    self.clickDefaultAddBlock();
                }

            } else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
        }
        
    }];
    
}

#pragma mark ---- 编辑 ----
- (void)editAddresClick:(UIButton *)sender {
    if (self.clickEditAddBlock) {
        self.clickEditAddBlock();
    }
}
#pragma mark ---- 删除 ----
- (void)deleteAddressClick:(UIButton *)sender {
    if (self.clickDeleteAddBlock) {
        self.clickDeleteAddBlock();
    }
}


- (void)setAddressM:(MyAddressViewModel *)addressM
{
    if (addressM) {
        _addressM = addressM;
        self.nameLabel.text = addressM.receiverName;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", addressM.province, addressM.city, addressM.county, addressM.receiverAddr];
        self.telephoneLabel.text = [NSString numberSuitScanf:IF_NULL_TO_STRING(addressM.receiverMp)];
        if ([addressM.defaultFlag isEqualToString:@"0"]) {
            self.defaultAddressBtn.selected = YES;
        } else {
            self.defaultAddressBtn.selected = NO;
        }

        
        
        
    }
}

@end
