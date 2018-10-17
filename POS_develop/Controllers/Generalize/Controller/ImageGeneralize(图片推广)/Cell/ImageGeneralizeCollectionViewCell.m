//
//  ImageGeneralizeCollectionViewCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ImageGeneralizeCollectionViewCell.h"

@implementation ImageGeneralizeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    _myImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_myImageView];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(AD_HEIGHT(-15));
        make.top.offset(AD_HEIGHT(6));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(167), AD_HEIGHT(144)));
    }];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.userInteractionEnabled = NO;
    [self.selectBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.selectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(5)];
    [self.selectBtn setImage:[UIImage imageNamed:@"图层5拷贝"] forState:normal];
    [self.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
//    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn.titleLabel.font = F12;
//    self.selectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(30));
        make.top.equalTo(self.myImageView.mas_bottom).offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(140), AD_HEIGHT(20)));
    }];
    
}


@end
