//
//  PosHomePageHeaderView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/22.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PosHomePageHeaderView.h"
#import "SLHomeFivePartBtn.h"
#import "XRCarouselView.h"
#import "BrandIntroductionViewController.h"//品牌介绍
#import "NullViewController.h"
@interface PosHomePageHeaderView ()<XRCarouselViewDelegate>
//轮播图
@property (nonatomic, strong) XRCarouselView *advView;
//总的view
@property (nonatomic, strong) UIView *contentV;

//推荐办卡
@property (nonatomic, strong) SLHomeFivePartBtn *starFansBtn;

//申请贷款
@property (nonatomic, strong) SLHomeFivePartBtn *maiBangKeBtn;

//免费领取
@property (nonatomic, strong) SLHomeFivePartBtn *bigVCardBtn;

//业务培训
@property (nonatomic, strong) SLHomeFivePartBtn *couponCenterBtn;

//品牌介绍
@property (nonatomic, strong) SLHomeFivePartBtn *starAllianceBtn;

@end
@implementation PosHomePageHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = WhiteColor;
    MJWeakSelf;
    
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
    self.teamPersonL.textAlignment = NSTextAlignmentCenter;
    self.teamPersonL.textColor = C000000;
    self.teamPersonL.font = F13;
    [numberBGImg addSubview:self.teamPersonL];
    [self.teamPersonL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberBGImg).offset(FITiPhone6(-19));
        make.bottom.equalTo(numberBGImg).offset(FITiPhone6(-9));
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    
    
    //总的view
    self.contentV = [[UIView alloc]init];
    self.contentV.backgroundColor = WhiteColor;
    [self addSubview:self.contentV];
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(numberBGImg.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(82)));
    }];
    
    //推荐办卡
    self.starFansBtn = [SLHomeFivePartBtn new];
    self.starFansBtn.holdImage = ImageNamed(@"推荐");
    self.starFansBtn.name = @"推荐办卡";
    [self.contentV addSubview:self.starFansBtn];
    //    [self.starFansBtn addTarget:self action:@selector(starFansBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.starFansBtn.selfClickEcho = ^{
        NullViewController *vc = [[NullViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
        //        [weakSelf starFansBtnClick];
    };
    //申请贷款
    self.maiBangKeBtn = [SLHomeFivePartBtn new];
    self.maiBangKeBtn.holdImage = ImageNamed(@"申请企业认证");
    self.maiBangKeBtn.name = @"申请贷款";
    [self.contentV addSubview:self.maiBangKeBtn];
    //    [self.maiBangKeBtn addTarget:self action:@selector(maiBangKeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.maiBangKeBtn.selfClickEcho = ^{
        NullViewController *vc = [[NullViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
        //        [weakSelf maiBangKeBtnClick];
    };
    //免费领取
    self.bigVCardBtn = [SLHomeFivePartBtn new];
    self.bigVCardBtn.holdImage = ImageNamed(@"立即领取");
    self.bigVCardBtn.name = @"免费领取";
    [self.contentV addSubview:self.bigVCardBtn];
    //    [self.bigVCardBtn addTarget:self action:@selector(bigVCardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.bigVCardBtn.selfClickEcho = ^{
        //        [weakSelf bigVCardBtnClick];
    };
    //业务培训
    self.couponCenterBtn = [SLHomeFivePartBtn new];
    self.couponCenterBtn.holdImage = ImageNamed(@"培训宣传");
    self.couponCenterBtn.name = @"业务培训";
    [self.contentV addSubview:self.couponCenterBtn];
    self.couponCenterBtn.selfClickEcho = ^{
        NullViewController *vc = [[NullViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
        //        [weakSelf couponCenterBtnClick];
    };
    //品牌介绍
    self.starAllianceBtn = [SLHomeFivePartBtn new];
    self.starAllianceBtn.holdImage = ImageNamed(@"介绍信息");
    self.starAllianceBtn.name = @"品牌介绍";
    [self.contentV addSubview:self.starAllianceBtn];
    //    [self.starAllianceBtn addTarget:self action:@selector(starAllianceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.starAllianceBtn.selfClickEcho = ^{
        BrandIntroductionViewController *vc = [[BrandIntroductionViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
        //        [weakSelf starAllianceBtnClick];
    };
    
    CGFloat btnW = (ScreenWidth-AD_WIDTH(25))/5;
    [self.starFansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(27));
        make.bottom.offset(-AD_HEIGHT(3));
        make.left.offset(AD_WIDTH(12.5));
        make.width.mas_offset(btnW);
    }];
    [self.maiBangKeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(27));
        make.bottom.offset(-AD_HEIGHT(3));
        make.left.mas_equalTo(weakSelf.starFansBtn.mas_right);
        make.width.mas_offset(btnW);
    }];
    [self.bigVCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(27));
        make.bottom.offset(-AD_HEIGHT(3));
        make.left.mas_equalTo(weakSelf.maiBangKeBtn.mas_right);
        make.width.mas_offset(btnW);
    }];
    [self.couponCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(27));
        make.bottom.offset(-AD_HEIGHT(3));
        make.left.mas_equalTo(weakSelf.bigVCardBtn.mas_right);
        make.width.mas_offset(btnW);
    }];
    [self.starAllianceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(27));
        make.bottom.offset(-AD_HEIGHT(3));
        make.left.mas_equalTo(weakSelf.couponCenterBtn.mas_right);
        make.width.mas_offset(btnW);
    }];
    
    
    
    
    //轮播图
    XRCarouselView *advView = [[XRCarouselView alloc] init];
    self.advView = advView;
    [self addSubview:self.advView];
    //用代理处理图片点击
    self.advView.delegate = self;
    //设置每张图片的停留时间，默认值为5s，最少为2s
    self.advView.time = 3;
    [advView setPageImage:ImageNamed(@"图层11拷贝2") andCurrentPageImage:ImageNamed(@"椭圆2拷贝")];
    //    [advView setPageColor:C_White_FFFFFF andCurrentPageColor:C_LightRed_EB3349];
    [_advView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(weakSelf.contentV.mas_bottom).offset(AD_HEIGHT(25));
        make.height.mas_equalTo(AD_HEIGHT(165));
    }];
    
    //组合套餐
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"组合套餐";
    textLabel.textColor = C000000;
    textLabel.font = F15;
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.advView.mas_bottom);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(80), AD_HEIGHT(44)));
    }];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [moreBtn setTitleColor:C989898 forState:UIControlStateNormal];
    //    [moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:AD_HEIGHT(-15)];
    //    [moreBtn setImage:[UIImage imageNamed:@"更多"] forState:normal];
    [moreBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.titleLabel.font = F12;
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    moreBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.mas_equalTo(AD_HEIGHT(90));
        make.right.equalTo(self).offset(AD_HEIGHT(-15));
        make.top.equalTo(weakSelf.advView.mas_bottom);
        make.height.mas_offset(AD_HEIGHT(44));
    }];
    
    
    
}

- (void)setAdArray:(NSArray *)adArray
{
    if (adArray) {
        _adArray = adArray;
        
        self.advView.imageArray = adArray;
    }
}


#pragma mark ---- 当月交易量和当月分润点击 ----
- (void)volumeOfTransactionClick {
    if (self.currentMonthBlock) {
        self.currentMonthBlock();
    }
}
#pragma mark -- 轮播图点击方法
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    
}
#pragma mark ---- 查看更多组合套餐 ----
- (void)moreClick:(UIButton *)sender {
    
}
@end
