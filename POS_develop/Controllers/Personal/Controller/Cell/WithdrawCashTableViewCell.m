//
//  WithdrawCashTableViewCell.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "WithdrawCashTableViewCell.h"

@implementation WithdrawCashTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"WithdrawCashTableViewCell";
    WithdrawCashTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WithdrawCashTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.titleLabel.textColor = C090909;
    self.titleLabel.font = F13;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.contentTF = [[UITextField alloc] init];
    self.contentTF.textColor = C090909;
    self.contentTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.contentTF.leftViewMode = UITextFieldViewModeAlways;
    [self.contentTF setValue:C989898
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    self.contentTF.borderStyle = UITextBorderStyleNone;
    self.contentTF.font = F13;
    self.contentTF.layer.cornerRadius = FITiPhone6(5);
    self.contentTF.layer.masksToBounds = YES;
    [self addSubview:_contentTF];
    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(108));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(108), FITiPhone6(13)));
    }];
    self.citySelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.citySelectBtn.hidden = YES;
    self.citySelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.citySelectBtn setTitle:@"请选择省份城市" forState:UIControlStateNormal];
    [self.citySelectBtn setTitleColor:C989898 forState:UIControlStateNormal];
    self.citySelectBtn.titleLabel.font = F13;
    [self.citySelectBtn addTarget:self action:@selector(citySelectClick) forControlEvents:UIControlEventTouchUpInside];
    self.citySelectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.citySelectBtn];
    [self.citySelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(108));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(20));
    }];
    self.totalWithdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalWithdrawBtn.hidden = YES;
    self.totalWithdrawBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.totalWithdrawBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [self.totalWithdrawBtn setTitleColor:CF70F0F forState:UIControlStateNormal];
    self.totalWithdrawBtn.titleLabel.font = F12;
    [self.totalWithdrawBtn addTarget:self action:@selector(totalWithdrawClick) forControlEvents:UIControlEventTouchUpInside];
    self.totalWithdrawBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalWithdrawBtn];
    [self.totalWithdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(20));
    }];
    
}
#pragma mark ---- 城市选择 ----
- (void)citySelectClick {
    
}
#pragma mark ---- 全部提现 ----
- (void)totalWithdrawClick {
    
}
@end














