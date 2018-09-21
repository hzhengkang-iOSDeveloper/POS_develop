//
//  AchievementsBottomCollectionViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/9/21.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AchievementsBottomCollectionViewCell.h"

@implementation AchievementsBottomCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _iconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(FITiPhone6(29));
        make.size.mas_offset(CGSizeMake(FITiPhone6(25), FITiPhone6(25)));
    }];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = C000000;
    _titleLabel.font = F13;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.iconImg.mas_bottom).offset(FITiPhone6(10));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    
}

@end
