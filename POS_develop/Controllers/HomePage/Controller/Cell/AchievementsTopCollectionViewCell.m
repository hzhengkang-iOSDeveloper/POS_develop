//
//  AchievementsTopCollectionViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/21.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AchievementsTopCollectionViewCell.h"

@implementation AchievementsTopCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = C000000;
    _titleLabel.font = F13;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(FITiPhone6(187.5), FITiPhone6(13)));
    }];
    _explainLabel = [[UILabel alloc] init];
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.textColor = C989898;
    _explainLabel.font = F13;
    [self.contentView addSubview:_explainLabel];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(self).offset(FITiPhone6(-17));
        make.size.mas_offset(CGSizeMake(FITiPhone6(187.5), FITiPhone6(11)));
    }];
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = CE6E2E2;
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView);
//        make.top.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
//        make.width.mas_offset(FITiPhone6(1));
//
//    }];
//    UIView *line1 = [[UIView alloc] init];
//    line1.backgroundColor = CE6E2E2;
//    [self.contentView addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
//        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(1)));
//        
//    }];
}

@end
