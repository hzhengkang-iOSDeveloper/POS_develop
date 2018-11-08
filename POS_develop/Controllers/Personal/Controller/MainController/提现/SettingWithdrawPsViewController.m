//
//  SettingWithdrawPsViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SettingWithdrawPsViewController.h"

@interface SettingWithdrawPsViewController ()
@property (nonatomic, weak) UILabel *passwordL;
@property (nonatomic, weak) UILabel  *surePasswordL;
@property (nonatomic, weak) UITextField *passwordTF;
@property (nonatomic, weak) UITextField *surePasswordTF;

@end

@implementation SettingWithdrawPsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"设置密码";
    [self initUI ];
}

- (void)initUI {
    UIView *whiteBgView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(101));
    }];
    UILabel *passwordL = [UILabel getLabelWithFont:F14 textColor:C000000 superView:whiteBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.height.mas_equalTo(AD_HEIGHT(50));
    }];
    self.passwordL = passwordL;
    passwordL.text = @"输入密码";
    UITextField *passwordTF = [[UITextField alloc] init];
    passwordTF.placeholder = @"请输入8~16位密码";
    passwordTF.textColor = C000000;
    passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF = passwordTF;
    [whiteBgView addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordL.mas_right).offset(AD_HEIGHT(48));
        make.centerY.equalTo(self.passwordL.mas_centerY);
        make.height.mas_equalTo(AD_HEIGHT(50));

    }];
    
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:whiteBgView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.top.equalTo(self.passwordL.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    UILabel *surePasswordL = [UILabel getLabelWithFont:F14 textColor:C000000 superView:whiteBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(50));
    }];
    self.surePasswordL = surePasswordL;
    surePasswordL.text = @"确认密码";
    
    UITextField *surePasswordTF = [[UITextField alloc] init];
    surePasswordTF.placeholder = @"请再次输入密码";
    surePasswordTF.textColor = C000000;
    surePasswordTF.borderStyle = UITextBorderStyleNone;
    self.surePasswordTF = surePasswordTF;
    [whiteBgView addSubview:surePasswordTF];
    [surePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.surePasswordL.mas_right).offset(AD_HEIGHT(48));
        make.centerY.equalTo(self.surePasswordL.mas_centerY);
        make.height.mas_equalTo(AD_HEIGHT(50));
    }];
    
     [UIButton getButtonWithImageName:@"" titleText:@"确定" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(self.surePasswordL.mas_bottom).offset(AD_HEIGHT(120));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30) , AD_HEIGHT(49)));
        
        btn.titleLabel.textColor = WhiteColor;
        btn.backgroundColor = C1E95F9;
        btn.titleLabel.font = F14;
        btn.layer.cornerRadius = AD_HEIGHT(5);
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    }];
}

#pragma mark ---- 设置密码 ----
- (void)sureClick {
    if (![self.passwordTF.text isEqualToString:self.surePasswordTF.text]) {
        HUD_TIP(@"两次密码不一致");
        return;
    }
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bag/update" params:@{@"id":self.withDrawPasswdID, @"withDrawPasswd":self.passwordTF.text, @"userid":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_TIP(@"设置密码成功");
                if (self.popBlock) {
                    self.popBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
