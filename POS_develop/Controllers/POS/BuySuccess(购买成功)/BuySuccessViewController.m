//
//  BuySuccessViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "BuySuccessViewController.h"

@interface BuySuccessViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeSum;
@property (nonatomic, strong) UILabel *successLabel;
@end

@implementation BuySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"购买成功";
    [self initUI];
}

- (void)initUI {
    UIImageView *successImageView = [[UIImageView alloc] init];
    successImageView.image = [UIImage imageNamed:@"分享成功"];
    [self.view addSubview:successImageView];
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(24));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(59), AD_HEIGHT(45)));
    }];
    self.successLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(successImageView.mas_bottom).offset(AD_HEIGHT(16));
    }];
    self.timeSum = 5;
    self.successLabel.text = [NSString stringWithFormat:@"%d秒倒计时返回首页", self.timeSum];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
    
    UIView *bgView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(self.successLabel.mas_bottom).offset(AD_HEIGHT(52));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30), AD_HEIGHT(107)));
    }];
    [[bgView layer] setShadowOffset:CGSizeMake(0, FITiPhone6(5))];
    [[bgView layer] setShadowRadius:FITiPhone6(7)];
    [[bgView layer] setShadowOpacity:0.2];
    [[bgView layer] setShadowColor:C000000.CGColor];
    
    UIButton *goHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goHomeBtn addTarget:self action:@selector(goHomeClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.qrCodeBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:goHomeBtn];
    [goHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    UIButton *seeOrderBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [seeOrderBtn addTarget:self action:@selector(seeOrderClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.imageBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:seeOrderBtn];
    [seeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.htmlBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    
    UIImageView *goHomeImageView = [[UIImageView alloc] init];
    goHomeImageView.image = [UIImage imageNamed:@"返回首页"];
    [bgView addSubview:goHomeImageView];
    [goHomeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(31));
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *goHomeLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.equalTo(goHomeImageView.mas_centerX);
        make.top.equalTo(goHomeImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    goHomeLabel.text = @"返回首页";
    
    UIImageView *seeOrderImageView = [[UIImageView alloc] init];
    seeOrderImageView.image = [UIImage imageNamed:@"查看订单"];
    [bgView addSubview:seeOrderImageView];
    [seeOrderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *seeOrderLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.equalTo(seeOrderImageView.mas_centerX);
        make.top.equalTo(seeOrderImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    seeOrderLabel.text = @"查看订单";
    
    UIImageView *shareImageView = [[UIImageView alloc] init];
    shareImageView.image = [UIImage imageNamed:@"朋友圈"];
    [bgView addSubview:shareImageView];
    [shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-40));
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *shareLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.equalTo(shareImageView.mas_centerX);
        make.top.equalTo(shareImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    shareLabel.text = @"分享到朋友圈";
}
-(void)timerChange:(NSTimer*)timer
{
    self.timeSum-=1;
    self.successLabel.text = [NSString stringWithFormat:@"%d秒倒计时返回首页", self.timeSum];
    if (self.timeSum<=0) {
        [timer invalidate];
        self.navigationController.tabBarController.selectedIndex=0;
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark ---- 返回首页 ----
- (void)goHomeClick {
    self.navigationController.tabBarController.selectedIndex=0;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark ---- 查看订单 ----
- (void)seeOrderClick {
    
}
#pragma mark ---- 分享到朋友圈 ----
- (void)shareClick {
    
}
@end
