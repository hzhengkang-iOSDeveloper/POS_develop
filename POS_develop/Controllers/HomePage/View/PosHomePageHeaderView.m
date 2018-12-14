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
#import "CombinationSetMealViewController.h"
#import "MyFreeGetViewController.h"
#import "HomeH5ViewController.h"
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
    
    
    
    
    //总的view
    self.contentV = [[UIView alloc]init];
    self.contentV.backgroundColor = WhiteColor;
    [self addSubview:self.contentV];
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
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
        MyFreeGetViewController *vc = [[MyFreeGetViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
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
    advView.contentMode = UIViewContentModeScaleAspectFill;
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
    textLabel.font = FB15;
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

- (void)setLinkArray:(NSArray *)linkArray
{
    if (linkArray) {
        _linkArray = linkArray;
        
    }
}
#pragma mark -- 轮播图点击方法
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    if ([IF_NULL_TO_STRING(self.linkArray[index]) isEqualToString:@""]) {
        return;
    }
    
    HomeH5ViewController *vc = [[HomeH5ViewController alloc]init];
    vc.urlLinkStr = self.linkArray[index];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- 查看更多组合套餐 ----
- (void)moreClick:(UIButton *)sender {
    CombinationSetMealViewController *vc = [[CombinationSetMealViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


@end
