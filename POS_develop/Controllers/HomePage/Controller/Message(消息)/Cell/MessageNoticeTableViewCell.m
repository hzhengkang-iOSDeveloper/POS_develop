//
//  MessageNoticeTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageNoticeTableViewCell.h"

@implementation MessageNoticeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessageNoticeTableViewCell";
    MessageNoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"logo"];
    self.iconImageView.layer.cornerRadius = AD_HEIGHT(35/2);
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(35), AD_HEIGHT(35)));
    }];
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(AD_HEIGHT(12));
        make.top.offset(AD_HEIGHT(17));
    }];
    self.contentLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(AD_HEIGHT(12));
        make.bottom.offset(AD_HEIGHT(-13));
    }];
    self.timeLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-15));
        make.top.offset(AD_HEIGHT(22));
    }];
    [UIView getViewWithColor:RGB(216, 214, 214) superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(0.5));
    }];
    
}
@end
