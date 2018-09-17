//
//  UpdatePhoneTableViewCell.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "UpdatePhoneTableViewCell.h"

@implementation UpdatePhoneTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"UpdatePasswordTableViewCell";
    UpdatePhoneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UpdatePhoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.contentTF = [[UITextField alloc] init];
    self.contentTF.textColor = C000000;
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
        make.left.equalTo(self).offset(FITiPhone6(113));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(170), FITiPhone6(13)));
    }];
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = C989898;
    self.lineView.hidden = YES;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-86));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(1), FITiPhone6(20)));
    }];
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCodeBtn.hidden = YES;
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:C1E95F9 forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = F12;
    [self.getCodeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
    self.getCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(FITiPhone6(11));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(20));
    }];
}

- (void)getCodeClick {
    if (self.getCodeBlock) {
        self.getCodeBlock();
    }
}

@end
