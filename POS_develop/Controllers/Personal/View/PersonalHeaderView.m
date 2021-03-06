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
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(217) + STATUSBAR_H));
    }];
    UIImageView *iconImageV = [[UIImageView alloc] init];
    self.iconImageV = iconImageV;
    iconImageV.image = [UIImage imageNamed:@"头像"];
    iconImageV.layer.cornerRadius = FITiPhone6(20);
    iconImageV.layer.masksToBounds = YES;
    [bgImageV addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV).offset(FITiPhone6(15));
        make.top.equalTo(bgImageV).offset(FITiPhone6(39) + STATUSBAR_H);
        make.size.mas_offset(CGSizeMake(FITiPhone6(40), FITiPhone6(40)));
    }];
    UIButton *userName = [UIButton buttonWithType:UIButtonTypeCustom];
    userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [userName setTitle:@"登录/注册" forState:UIControlStateNormal];
    [userName setTitleColor:WhiteColor forState:UIControlStateNormal];
    [userName addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    userName.titleLabel.font = F15;
    userName.hidden = YES;
    self.userName = userName;
    [bgImageV addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(FITiPhone6(12));
        make.centerY.equalTo(iconImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(100), FITiPhone6(13)));
    }];
    
    self.userNameLabel = [UILabel getLabelWithFont:F13 textColor:WhiteColor superView:bgImageV masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(FITiPhone6(12));
        make.top.equalTo(bgImageV).offset(FITiPhone6(45) + STATUSBAR_H);
    }];
    self.userNameLabel.hidden = YES;
    self.invitedCodeLabel = [UILabel getLabelWithFont:F10 textColor:WhiteColor superView:bgImageV masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(FITiPhone6(12));
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(FITiPhone6(5));
    }];
    self.invitedCodeLabel.hidden = YES;
    
//    UIImageView *messageV = [[UIImageView alloc] init];
//
//    messageV.userInteractionEnabled = YES;
////    UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(messageClick)];
////    //为图片添加手势
////    [messageV addGestureRecognizer:singleTap];
//    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(messageClick)];
//    [messageV addGestureRecognizer:tap];
//    messageV.image = [UIImage imageNamed:@"消息"];
//    self.messageV = messageV;
//    [bgImageV addSubview:messageV];
//    [messageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(bgImageV).offset(FITiPhone6(-21));
//        make.top.equalTo(bgImageV).offset(FITiPhone6(20) + STATUSBAR_H);
//        make.size.mas_offset(CGSizeMake(FITiPhone6(17), FITiPhone6(15)));
//    }];
    

    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setBackgroundImage:ImageNamed(@"消息") forState:normal];
    [bgImageV addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV).offset(FITiPhone6(-21));
        make.top.equalTo(bgImageV).offset(FITiPhone6(20) + STATUSBAR_H);
        make.size.mas_offset(CGSizeMake(FITiPhone6(17), FITiPhone6(15)));
    }];
    self.messageBtn = messageBtn;
    [messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *yesterdayEarningsText = [[UILabel alloc] init];
    yesterdayEarningsText.text = @"昨日收益";
    yesterdayEarningsText.textColor = WhiteColor;
    yesterdayEarningsText.font = F15;
    yesterdayEarningsText.textAlignment = NSTextAlignmentCenter;
    [bgImageV addSubview:yesterdayEarningsText];
    [yesterdayEarningsText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV);
        make.top.equalTo(bgImageV).offset(FITiPhone6(87) + STATUSBAR_H);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(15)));
    }];
    self.yesterdayEarningsMoney = [[UILabel alloc] init];
//    self.yesterdayEarningsMoney.text = @"0.00";
    self.yesterdayEarningsMoney.textColor = WhiteColor;
    self.yesterdayEarningsMoney.font = F15;
    self.yesterdayEarningsMoney.textAlignment = NSTextAlignmentCenter;
    [bgImageV addSubview:self.yesterdayEarningsMoney];
    [self.yesterdayEarningsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.balanceL = [[UILabel alloc] init];
    self.balanceL.textColor = WhiteColor;
    self.balanceL.font = F15;
    [bgImageV addSubview:self.balanceL];
    [self.balanceL mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.bottom.equalTo(self.balanceL.mas_bottom);
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

#pragma mark -- 消息点击
- (void)messageClick {
    if (self.messageBlock) {
        self.messageBlock();
    }
}
@end









