//
//  MessageListTableViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageListTableViewCell.h"

@implementation MessageListTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessageListTableViewCell";
    MessageListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.contentView.backgroundColor = CF6F6F6;
    self.timeImageView = [[UIImageView alloc] init];
    self.timeImageView.image = [UIImage imageNamed:@"日期"];
    [self.contentView addSubview:self.timeImageView];
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(8));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(13), AD_HEIGHT(13)));
    }];
    self.timeLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.timeImageView.mas_right).offset(AD_HEIGHT(7));
        make.top.offset(AD_HEIGHT(12));
    }];
    
    UIView *whiteBgView = [UIView getViewWithColor:WhiteColor superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(self.timeLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.height.mas_equalTo(AD_HEIGHT(88));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    whiteBgView.layer.cornerRadius = AD_HEIGHT(5);
    whiteBgView.layer.masksToBounds = YES;
    
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:whiteBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(5));
        make.top.offset(AD_HEIGHT(7));
    }];
    
    self.iconImageView = [[UIImageView alloc] init];
//    self.iconImageView.image = [UIImage imageNamed:@"培训宣传"];
    [whiteBgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(5));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(5));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(40), AD_HEIGHT(40)));
    }];
    
    self.contentLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:whiteBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(AD_HEIGHT(14));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(6));
        make.right.offset(AD_HEIGHT(-7));
    }];
    self.contentLabel.numberOfLines = 0;
    
    UIView *lineView = [UIView getViewWithColor:RGB(216, 214, 214) superView:whiteBgView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(AD_HEIGHT(5));
        make.height.mas_equalTo(AD_HEIGHT(0.5));
    }];
    self.detailLabel = [UILabel getLabelWithFont:F10 textColor:C000000 superView:whiteBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(5));
        make.top.equalTo(lineView.mas_bottom).offset(AD_HEIGHT(5));
        make.bottom.offset(AD_HEIGHT(-5));
    }];
    self.detailLabel.text = @"查看详情";
    self.detailImageView = [[UIImageView alloc] init];
    self.detailImageView.image = [UIImage imageNamed:@"更多"];
    [whiteBgView addSubview:self.detailImageView];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-5));
        make.centerY.equalTo(self.detailLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(6), AD_HEIGHT(6)));
    }];
}

@end
