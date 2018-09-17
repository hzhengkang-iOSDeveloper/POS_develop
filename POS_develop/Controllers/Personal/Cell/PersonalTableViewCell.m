//
//  PersonalTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"PersonalTableViewCell";
    PersonalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.myImageView = [[UIImageView alloc] init];
    [self addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(FITiPhone6(18), FITiPhone6(17)));
    }];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = C000000;
    self.titleLabel.font = F13;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(FITiPhone6(22));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(FITiPhone6(60), FITiPhone6(13)));
    }];
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = CE6E2E2;
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(0.5)));
    }];
}
@end
