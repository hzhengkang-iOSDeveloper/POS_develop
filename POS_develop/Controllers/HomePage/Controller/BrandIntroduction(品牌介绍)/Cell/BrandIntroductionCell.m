//
//  BrandIntroductionCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BrandIntroductionCell.h"

@implementation BrandIntroductionCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"BrandIntroductionCell";
    BrandIntroductionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BrandIntroductionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        make.top.offset(AD_HEIGHT(9));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30), AD_HEIGHT(192)));
    }];
    UIView *bgView = [UIView getViewWithColor:RGB(32, 32, 32) superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.equalTo(self.myImageView.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30), AD_HEIGHT(49)));
        
    }];
    bgView.alpha = 0.6;
    self.titleLabel = [UILabel getLabelWithFont:F15 textColor:WhiteColor superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    self.contentLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.mas_equalTo(self.myImageView.mas_bottom).offset(AD_HEIGHT(5));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
        make.bottom.offset(0);
    }];
    self.contentLabel.numberOfLines = 0;
}

- (CGFloat)getCellHeight {
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.contentLabel.frame);
}
@end
