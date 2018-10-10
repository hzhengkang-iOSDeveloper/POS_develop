//
//  ShareSuccessViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ShareSuccessViewController.h"

@interface ShareSuccessViewController ()

@end

@implementation ShareSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"分享";
    [self initUI];
}

- (void)initUI {
    UIImageView *successImageView = [[UIImageView alloc] init];
    successImageView.image = [UIImage imageNamed:@"成功"];
    [self.view addSubview:successImageView];
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(24));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(59), AD_HEIGHT(45)));
    }];
    UILabel *successLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(successImageView.mas_bottom).offset(AD_HEIGHT(16));
    }];
    successLabel.text = @"分享成功!";
    
    
    UIView *bgView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(successLabel.mas_bottom).offset(AD_HEIGHT(52));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30), AD_HEIGHT(107)));
    }];
    [[bgView layer] setShadowOffset:CGSizeMake(0, FITiPhone6(5))];
    [[bgView layer] setShadowRadius:FITiPhone6(7)];
    [[bgView layer] setShadowOpacity:0.2];
    [[bgView layer] setShadowColor:C000000.CGColor];
    
    UIButton *goHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goHomeBtn addTarget:self action:@selector(goHomeClick) forControlEvents:UIControlEventTouchUpInside];
//    goHomeBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:goHomeBtn];
    [goHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(147), AD_HEIGHT(107-30)));
    }];
    UIButton *againShareBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [againShareBtn addTarget:self action:@selector(againShareClick) forControlEvents:UIControlEventTouchUpInside];
//    againShareBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:againShareBtn];
    [againShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(147), AD_HEIGHT(107-30)));
    }];
    
    UIImageView *goHomeImageView = [[UIImageView alloc] init];
    goHomeImageView.image = [UIImage imageNamed:@"返回首页"];
    [bgView addSubview:goHomeImageView];
    [goHomeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(82));
        make.top.offset(AD_HEIGHT(25));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(28), AD_HEIGHT(25)));
    }];
    UILabel *goHomeLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
       make.centerX.equalTo(goHomeImageView.mas_centerX);
        make.top.equalTo(goHomeImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    goHomeLabel.text = @"返回首页";
    
    UIImageView *againShareImageView = [[UIImageView alloc] init];
    againShareImageView.image = [UIImage imageNamed:@"再次分享"];
    [bgView addSubview:againShareImageView];
    [againShareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-85));
        make.top.offset(AD_HEIGHT(25));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(25), AD_HEIGHT(25)));
    }];
    UILabel *againShareLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
//        make.right.offset(-15);
        make.centerX.equalTo(againShareImageView.mas_centerX);
        make.top.equalTo(againShareImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    againShareLabel.text = @"再次分享";
    
}
#pragma mark ---- 返回首页 ----
- (void)goHomeClick {
    self.navigationController.tabBarController.selectedIndex=0;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark ---- 再次分享 ----
- (void)againShareClick {
    
}
@end
