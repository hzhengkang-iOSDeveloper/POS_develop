//
//  ActivationMoneyDetailHeaderView.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ActivationMoneyDetailHeaderView.h"

@implementation ActivationMoneyDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIView *bgImageV = [[UIView alloc]init];
    [self addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(120)));
    }];
    [self layoutIfNeeded];
    [bgImageV setBtnGradientStartColor:[UIColor colorWithHexString:@"#46baf4"] EndColor:[UIColor colorWithHexString:@"#9bd4f0"] GradientType:GradientTypeHorizontal];

    
    
    UIImageView *searchImageV = [[UIImageView alloc] init];
    searchImageV.userInteractionEnabled = YES;
    searchImageV.image = [UIImage imageNamed:@"搜索框"];
    UITapGestureRecognizer *searchTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTap)];
    [searchImageV addGestureRecognizer:searchTap];
    [bgImageV addSubview:searchImageV];
    [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(5));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
    }];
    UIImageView *searchImgV = [[UIImageView alloc] init];
    searchImgV.userInteractionEnabled = YES;
    searchImgV.image = [UIImage imageNamed:@"搜索"];
    [searchImageV addSubview:searchImgV];
    [searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.centerY.equalTo(searchImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(16), FITiPhone6(16)));
    }];
    

    
    UIImageView *numberBGImg = [[UIImageView alloc] init];
    numberBGImg.userInteractionEnabled = YES;
    numberBGImg.layer.cornerRadius = FITiPhone6(5);
    numberBGImg.layer.masksToBounds = YES;
    numberBGImg.image = [UIImage imageNamed:@"背景home"];
    [self addSubview:numberBGImg];
    [numberBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(16));
        make.top.equalTo(bgImageV.mas_bottom).offset(-AD_HEIGHT(35));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(32), FITiPhone6(71)));
    }];
    
    
    UILabel *totalPen = [[UILabel alloc] init];
    totalPen.text = @"返现金额(元)";
    totalPen.textColor = C000000;
    totalPen.font = F13;
    totalPen.adjustsFontSizeToFitWidth = YES;
    [numberBGImg addSubview:totalPen];
    [totalPen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberBGImg).offset(FITiPhone6(67));
        make.top.equalTo(numberBGImg).offset(FITiPhone6(20));
        //        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.totalPenLabel = [[UILabel alloc] init];
    self.totalPenLabel.textAlignment = NSTextAlignmentCenter;
    self.totalPenLabel.textColor = C000000;
    self.totalPenLabel.font = F13;
    [numberBGImg addSubview:self.totalPenLabel];
    [self.totalPenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(numberBGImg).offset(FITiPhone6(19));
        make.centerX.equalTo(totalPen.mas_centerX);
        make.top.equalTo(totalPen.mas_bottom).offset(FITiPhone6(9));
        make.size.mas_offset(CGSizeMake(FITiPhone6(180), FITiPhone6(13)));
    }];
    UILabel *totalAmount = [[UILabel alloc] init];
    totalAmount.text = @"激活数量(台)";
    totalAmount.textColor = C000000;
    totalAmount.font = F13;
    totalAmount.adjustsFontSizeToFitWidth = YES;
    [numberBGImg addSubview:totalAmount];
    [totalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberBGImg).offset(FITiPhone6(-53));
        make.top.equalTo(totalPen.mas_top);
        //        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.totalAmountLabel = [[UILabel alloc] init];
    self.totalAmountLabel.textAlignment = NSTextAlignmentCenter;
    self.totalAmountLabel.textColor = C000000;
    self.totalAmountLabel.font = F13;
    [numberBGImg addSubview:self.totalAmountLabel];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalAmount.mas_centerX);
        make.top.equalTo(totalAmount.mas_bottom).offset(FITiPhone6(9));
        make.size.mas_offset(CGSizeMake(FITiPhone6(180), FITiPhone6(13)));
    }];
    
}

#pragma mark ---- 搜索框点击 ----
- (void)searchTap {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

@end
