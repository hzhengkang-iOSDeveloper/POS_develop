//
//  HtmlGenerailzeCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeCell.h"

@implementation HtmlGenerailzeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"HtmlGenerailzeCell";
    HtmlGenerailzeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HtmlGenerailzeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AD_HEIGHT(15));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right).offset(AD_HEIGHT(16));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(45)));
    }];
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = C000000;
    self.contentLabel.font = F13;
    self.contentLabel.numberOfLines = 2;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(AD_HEIGHT(17));
        make.top.offset(AD_HEIGHT(18));
        make.right.offset(AD_HEIGHT(-15));
    }];
    
    self.seeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seeDetailBtn setTitle:@"查看分析详情 >" forState:UIControlStateNormal];
    [self.seeDetailBtn setTitleColor:C1E95F9 forState:UIControlStateNormal];
    self.seeDetailBtn.titleLabel.font = F10;
    [self.seeDetailBtn addTarget:self action:@selector(seeDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.seeDetailBtn];
    [self.seeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-18));
        make.bottom.offset(AD_HEIGHT(-5));
        make.height.mas_equalTo(AD_HEIGHT(10));
//        make.top.equalTo(self.contentLabel.mas_bottom).offset(AD_HEIGHT(7));
    }];
    [UIView getViewWithColor:RGB(230, 226, 226) superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
        make.bottom.offset(0);
    }];
    
}

- (void)seeDetailBtnClick {
    if (self.seeDetailBtn) {
        self.seeDetailBlock();
    }
}

@end
