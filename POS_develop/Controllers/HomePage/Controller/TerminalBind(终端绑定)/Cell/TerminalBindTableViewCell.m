//
//  TerminalBindTableViewCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalBindTableViewCell.h"

@implementation TerminalBindTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TerminalBindTableViewCell";
    TerminalBindTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TerminalBindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.productNameL = [[UILabel alloc] init];
    self.productNameL.textColor = C000000;
    self.productNameL.font = F13;
//    self.productNameL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.productNameL];
    [self.productNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(FITiPhone6(15));
        make.top.equalTo(self.contentView).offset(FITiPhone6(14));
//        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.viceProductNameL = [[UILabel alloc] init];
    self.viceProductNameL.textColor = C989898;
    self.viceProductNameL.font = F9;
//    self.viceProductNameL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.viceProductNameL];
    [self.viceProductNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productNameL.mas_right).offset(FITiPhone6(5));
        make.bottom.equalTo(self.productNameL.mas_bottom);
//        make.height.mas_equalTo(FITiPhone6(11));
    }];
    self.snL = [[UILabel alloc] init];
    self.snL.textColor = C000000;
    self.snL.font = F12;
//    self.snL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.snL];
    [self.snL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(FITiPhone6(15));
        make.bottom.equalTo(self.contentView).offset(FITiPhone6(-14));
//        make.height.mas_equalTo(FITiPhone6(11));
    }];
    self.modelL = [[UILabel alloc] init];
    self.modelL.textColor = C000000;
    self.modelL.font = F12;
//    self.modelL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.modelL];
    [self.modelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(FITiPhone6(-15));
        make.bottom.equalTo(self.productNameL.mas_bottom);
//        make.height.mas_equalTo(FITiPhone6(14));
    }];
    
    self.bindStateL = [[UILabel alloc] init];
    self.bindStateL.hidden = YES;
    self.bindStateL.textColor = C000000;
    self.bindStateL.font = F12;
    [self.contentView addSubview:self.bindStateL];
    [self.bindStateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(FITiPhone6(-22));
        make.bottom.equalTo(self.snL.mas_bottom);
    }];
}
@end
