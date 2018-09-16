 //
//  PersonalHeaderView.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PersonalHeaderView.h"

@implementation PersonalHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIImageView *bgImageV = [[UIImageView alloc] init];
    bgImageV.userInteractionEnabled = YES;
    bgImageV.image = [UIImage imageNamed:@"图层1拷贝"];
    [self addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(217)));
    }];
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.image = [UIImage imageNamed:@"头像"];
    [bgImageV addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV).offset(FITiPhone6(15));
        make.top.equalTo(bgImageV).offset(FITiPhone6(20));
        make.size.mas_offset(CGSizeMake(FITiPhone6(40), FITiPhone6(40)));
    }];
    UIButton *userName = [UIButton buttonWithType:UIButtonTypeCustom];
    userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [userName setTitle:@"登录/注册" forState:UIControlStateNormal];
    [userName setTitleColor:WhiteColor forState:UIControlStateNormal];
    [userName addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    userName.titleLabel.font = F15;
    [bgImageV addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(FITiPhone6(12));
        make.centerY.equalTo(iconImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(100), FITiPhone6(13)));
    }];
    UIImageView *messageV = [[UIImageView alloc] init];
    messageV.image = [UIImage imageNamed:@"消息"];
    [bgImageV addSubview:messageV];
    [messageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV).offset(FITiPhone6(-21));
        make.top.equalTo(bgImageV).offset(FITiPhone6(20));
        make.size.mas_offset(CGSizeMake(FITiPhone6(17), FITiPhone6(15)));
    }];
    UILabel *yesterdayEarningsText = [[UILabel alloc] init];
    yesterdayEarningsText.text = @"昨日收益";
    yesterdayEarningsText.textColor = WhiteColor;
    yesterdayEarningsText.font = F15;
    yesterdayEarningsText.textAlignment = NSTextAlignmentCenter;
    [bgImageV addSubview:yesterdayEarningsText];
    [yesterdayEarningsText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV);
        make.top.equalTo(bgImageV).offset(FITiPhone6(87));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(15)));
    }];
    UILabel *yesterdayEarningsMoney = [[UILabel alloc] init];
    yesterdayEarningsMoney.text = @"0.00";
    yesterdayEarningsMoney.textColor = WhiteColor;
    yesterdayEarningsMoney.font = F15;
    yesterdayEarningsMoney.textAlignment = NSTextAlignmentCenter;
    [bgImageV addSubview:yesterdayEarningsMoney];
    [yesterdayEarningsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV);
        make.top.equalTo(yesterdayEarningsText.mas_bottom).offset(FITiPhone6(12));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(15)));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = WhiteColor;
    [bgImageV addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV);
        make.bottom.equalTo(bgImageV).offset(FITiPhone6(-51));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(0.5)));
    }];
    UILabel *balanceL = [[UILabel alloc] init];
    balanceL.text = @"余额 300.00";
    balanceL.textColor = WhiteColor;
    balanceL.font = F15;
    [bgImageV addSubview:balanceL];
    [balanceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV).offset(FITiPhone6(15));
        make.bottom.equalTo(bgImageV).offset(FITiPhone6(-17));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(120), FITiPhone6(15)));
    }];
    UIButton *withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdrawBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    [withdrawBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [withdrawBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(15)];
    [withdrawBtn setImage:[UIImage imageNamed:@"图层3"] forState:normal];
    [withdrawBtn addTarget:self action:@selector(withdrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    withdrawBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    withdrawBtn.titleLabel.font = F15;
    [bgImageV addSubview:withdrawBtn];
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV).offset(FITiPhone6(-15));
        make.bottom.equalTo(balanceL.mas_bottom);
        make.size.mas_offset(CGSizeMake(FITiPhone6(100), FITiPhone6(15)));
    }];
}
#pragma mark ---- 立即提现 ----
- (void)withdrawBtnClick {
    if (self.withdrawBlock) {
        self.withdrawBlock();
    }
}
#pragma mark ---- 注册/登录 ----
- (void)LoginClick {
    if (self.loginBlock) {
        self.loginBlock();
    }
}
@end









