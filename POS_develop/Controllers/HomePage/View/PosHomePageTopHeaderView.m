//
//  PosHomePageTopHeaderView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/11/2.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PosHomePageTopHeaderView.h"

@implementation PosHomePageTopHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = WhiteColor;
    UIView *bgImageV = [[UIView alloc]init];
    [self addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(140)));
    }];
    [self layoutIfNeeded];
    [bgImageV setBtnGradientStartColor:[UIColor colorWithHexString:@"#46baf4"] EndColor:[UIColor colorWithHexString:@"#9bd4f0"] GradientType:GradientTypeHorizontal];
    
    UILabel *volumeOfTransaction = [[UILabel alloc] init];
    volumeOfTransaction.text = @"当月交易量(万)";
    volumeOfTransaction.textColor = WhiteColor;
    volumeOfTransaction.font = F15;
    [self addSubview:volumeOfTransaction];
    [volumeOfTransaction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(35));
        make.top.equalTo(self).offset(FITiPhone6(25));
        make.size.mas_offset(CGSizeMake(ScreenWidth/2 - FITiPhone6(70), FITiPhone6(15)));
    }];
    self.volumeOfTransactionL = [[UILabel alloc] init];
    self.volumeOfTransactionL.textColor = WhiteColor;
    self.volumeOfTransactionL.text = @"0";
    self.volumeOfTransactionL.font = F15;
    [self addSubview:self.volumeOfTransactionL];
    [self.volumeOfTransactionL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(35));
        make.top.equalTo(volumeOfTransaction.mas_bottom).offset(FITiPhone6(21));
        make.size.mas_offset(CGSizeMake(ScreenWidth/2 - FITiPhone6(70), FITiPhone6(15)));
    }];
    UIButton *volumeOfTransactionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    volumeOfTransactionBtn.backgroundColor = [UIColor redColor];
    [volumeOfTransactionBtn addTarget:self action:@selector(volumeOfTransactionClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:volumeOfTransactionBtn];
    [volumeOfTransactionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(35));
        make.top.equalTo(self).offset(FITiPhone6(25));
        make.size.mas_offset(CGSizeMake(ScreenWidth/2 - FITiPhone6(70), FITiPhone6(60)));
    }];
    UILabel *shareProfit = [[UILabel alloc] init];
    shareProfit.text = @"当月分润(元)";
    shareProfit.textColor = WhiteColor;
    shareProfit.font = F15;
    [self addSubview:shareProfit];
    [shareProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(253));
        make.top.equalTo(volumeOfTransaction.mas_top);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(221) - FITiPhone6(35), FITiPhone6(15)));
    }];
    self.shareProfitL = [[UILabel alloc] init];
    self.shareProfitL.textColor = WhiteColor;
    self.shareProfitL.text = @"0.00";
    self.shareProfitL.font = F15;
    [self addSubview:self.shareProfitL];
    [self.shareProfitL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareProfit.mas_left);
        make.top.equalTo(self.volumeOfTransactionL.mas_top);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(221) - FITiPhone6(35), FITiPhone6(15)));
    }];
    UIButton *shareProfitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    shareProfitBtn.backgroundColor = [UIColor redColor];
    [shareProfitBtn addTarget:self action:@selector(volumeOfTransactionClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareProfitBtn];
    [shareProfitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ScreenWidth - FITiPhone6(151));
        make.top.equalTo(self).offset(FITiPhone6(25));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(221) - FITiPhone6(35), FITiPhone6(60)));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = WhiteColor;
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(volumeOfTransaction.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(1), FITiPhone6(33)));
    }];
    UIImageView *numberBGImg = [[UIImageView alloc] init];
    numberBGImg.userInteractionEnabled = YES;
    numberBGImg.layer.cornerRadius = FITiPhone6(5);
    numberBGImg.userInteractionEnabled = YES;
    numberBGImg.image = [UIImage imageNamed:@"背景home"];
    [self addSubview:numberBGImg];
    [numberBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(16));
        make.top.equalTo(bgImageV.mas_bottom).offset(-AD_HEIGHT(30));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(32), FITiPhone6(62)));
    }];
    UILabel *activation = [[UILabel alloc] init];
    activation.text = @"当月激活数量";
    activation.textColor = C000000;
    activation.font = F13;
    [numberBGImg addSubview:activation];
    [activation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberBGImg).offset(FITiPhone6(19));
        make.top.equalTo(numberBGImg).offset(FITiPhone6(15));
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    self.activationL = [[UILabel alloc] init];
    self.activationL.textAlignment = NSTextAlignmentCenter;
    self.activationL.text = @"0";
    self.activationL.textColor = C000000;
    self.activationL.font = F13;
    [numberBGImg addSubview:self.activationL];
    [self.activationL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberBGImg).offset(FITiPhone6(19));
        make.bottom.equalTo(numberBGImg).offset(FITiPhone6(-9));
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    UILabel *teamPerson = [[UILabel alloc] init];
    teamPerson.text = @"当前团队人数";
    teamPerson.textColor = C000000;
    teamPerson.font = F13;
    [numberBGImg addSubview:teamPerson];
    [teamPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberBGImg).offset(FITiPhone6(-19));
        make.top.equalTo(activation.mas_top);
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    self.teamPersonL = [[UILabel alloc] init];
    self.teamPersonL.text = @"0";
    self.teamPersonL.textAlignment = NSTextAlignmentCenter;
    self.teamPersonL.textColor = C000000;
    self.teamPersonL.font = F13;
    [numberBGImg addSubview:self.teamPersonL];
    [self.teamPersonL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberBGImg).offset(FITiPhone6(-19));
        make.bottom.equalTo(numberBGImg).offset(FITiPhone6(-9));
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    
}


#pragma mark ---- 当月交易量和当月分润点击 ----
- (void)volumeOfTransactionClick {
    if (self.currentMonthBlock) {
        self.currentMonthBlock();
    }
}

@end
