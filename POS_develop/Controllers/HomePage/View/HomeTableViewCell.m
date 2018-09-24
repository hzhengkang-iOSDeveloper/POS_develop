//
//  HomeTableViewCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/22.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"HomeTableViewCell";
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
- (void)initUI {
    self.bgImg = [[UIImageView alloc] init];
    self.bgImg.layer.cornerRadius = FITiPhone6(5);
    self.bgImg.layer.masksToBounds = YES;
    [self addSubview:self.bgImg];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(192)));
    }];
    
    UIView *opcityView = [[UIView alloc] init];
    opcityView.backgroundColor = RGBA(32, 32, 32, 0.6);
    [self.bgImg addSubview:opcityView];
    [opcityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.bottom.equalTo(self.bgImg);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(49)));
    }];
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    self.label.textColor = WhiteColor;
    self.label.font = F12;
    [self.bgImg addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(opcityView);
        make.top.equalTo(opcityView).offset(FITiPhone6(14));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(35)));
    }];
}
@end
