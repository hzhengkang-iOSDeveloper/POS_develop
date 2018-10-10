//
//  SetMealOrderCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SetMealOrderCell.h"

@implementation SetMealOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SetMealOrderCell";
    SetMealOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SetMealOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.myImageView = [[UIImageView alloc] init];
    self.myImageView.image = [UIImage imageNamed:@"图层7"];
    [self.contentView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(8));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(80), AD_HEIGHT(69)));
    }];
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.myImageView.mas_right).offset(AD_HEIGHT(26));
        make.top.equalTo(self.myImageView.mas_top);
        
    }];
    self.purchasePrice = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(7));
        
    }];
    self.activationCash = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.purchasePrice.mas_bottom).offset(AD_HEIGHT(7));
        
    }];
    self.number = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-16));
        make.top.offset(AD_HEIGHT(8));
    }];
    [UIView getViewWithColor:CE6E2E2 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(0.5));
    }];
}

@end
