//
//  TerminalAdminTableViewCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/2.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalAdminTableViewCell.h"

@implementation TerminalAdminTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TerminalAdminTableViewCell";
    TerminalAdminTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TerminalAdminTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"图层4拷贝10"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    self.selectBtn.userInteractionEnabled = NO;
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(15), FITiPhone6(15)));
    }];
    self.delegateName = [[UILabel alloc] init];
    self.delegateName.textColor = C000000;
    self.delegateName.font = F13;
    self.delegateName.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.delegateName];
    [self.delegateName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right).offset(FITiPhone6(14));
        make.top.equalTo(self).offset(FITiPhone6(12));
    }];
    self.delegateAccount = [[UILabel alloc] init];
    self.delegateAccount.textColor = C000000;
    self.delegateAccount.font = F13;
    self.delegateAccount.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.delegateAccount];
    [self.delegateAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.delegateName.mas_left);
        make.bottom.equalTo(self).offset(FITiPhone6(-10));
    }];

}

@end
