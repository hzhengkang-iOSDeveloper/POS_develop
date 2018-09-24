//
//  LoginTypeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "LoginTypeViewController.h"
#import "PasswordLoginViewController.h"
#import "FastLoginViewController.h"
#import "RegisterViewController.h"

@interface LoginTypeViewController ()

@end

@implementation LoginTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"登录方式";
    self.view.backgroundColor = WhiteColor;
    [self initUI];
}

- (void)initUI {
    UIImageView *logoImageV = [[UIImageView alloc] init];
    logoImageV.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageV];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(FITiPhone6(150), FITiPhone6(150)));
    }];
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registerBtn setTitle:@"<手机号一键注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.font = F12;
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(logoImageV.mas_bottom).offset(FITiPhone6(10));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(13)));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CE6E2E2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(registerBtn.mas_bottom).offset(FITiPhone6(7));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(0.5)));
    }];
    UIButton *fastLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fastLoginBtn.backgroundColor = RGB(238, 238, 238);
    [fastLoginBtn setTitle:@"手机号快捷登录" forState:UIControlStateNormal];
    [fastLoginBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(10)];
    [fastLoginBtn setImage:[UIImage imageNamed:@"手机号"] forState:normal];
    [fastLoginBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [fastLoginBtn addTarget:self action:@selector(fastLoginClick) forControlEvents:UIControlEventTouchUpInside];
    fastLoginBtn.titleLabel.font = F12;
    [self.view addSubview:fastLoginBtn];
    [fastLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(lineView.mas_bottom).offset(FITiPhone6(28));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
    UIButton *passwordLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordLoginBtn.backgroundColor = RGB(238, 238, 238);
    [passwordLoginBtn setTitle:@"手机号密码登录" forState:UIControlStateNormal];
    [passwordLoginBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(10)];
    [passwordLoginBtn setImage:[UIImage imageNamed:@"密码"] forState:normal];
    [passwordLoginBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [passwordLoginBtn addTarget:self action:@selector(passwordLoginClick) forControlEvents:UIControlEventTouchUpInside];
    passwordLoginBtn.titleLabel.font = F12;
    [self.view addSubview:passwordLoginBtn];
    [passwordLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(fastLoginBtn.mas_bottom).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
}

#pragma mark ---- 注册 ----
- (void)registerClick {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- 手机号快捷登录 ----
- (void)fastLoginClick {
    FastLoginViewController *vc = [[FastLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- 手机号密码登录 ----
- (void)passwordLoginClick {
    PasswordLoginViewController *vc = [[PasswordLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end















