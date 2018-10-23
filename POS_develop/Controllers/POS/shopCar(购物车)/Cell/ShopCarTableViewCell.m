//
//  ShopCarTableViewCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ShopCarTableViewCell.h"

@implementation ShopCarTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"ShopCarTableViewCell";
    ShopCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShopCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.myImageView.image = ImageNamed(@"图层7");
    [self.contentView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AD_HEIGHT(42));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(43)));
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"创业包（立刷999）";
    self.titleLabel.textColor = C000000;
    self.titleLabel.font = F12;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myImageView.mas_right).offset(AD_HEIGHT(12));
        make.top.offset(AD_HEIGHT(13));
    }];
    
    
    self.amountLabel = [UILabel getLabelWithFont:F13 textColor:RGB(240, 21, 21) superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(9));
        make.left.equalTo(self.titleLabel.mas_left);
        
        view.text = @"￥550";
    }];
    self.numberLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.offset(AD_HEIGHT(-17));
        
        view.text = @"x1";
    }];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = CE6E2E2;
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AD_HEIGHT(15));
        make.bottom.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}

@end
