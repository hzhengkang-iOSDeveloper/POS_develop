//
//  PasswordLoginViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "AFNetworking.h"
@interface PasswordLoginViewController () {
    UIActivityIndicatorView *_aview;
}
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation PasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPop = YES;
    self.navigationItemTitle = @"手机号密码登录";
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
    UIButton *otherTypeLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    otherTypeLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [otherTypeLoginBtn setTitle:@"<其他方式登录" forState:UIControlStateNormal];
    [otherTypeLoginBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [otherTypeLoginBtn addTarget:self action:@selector(otherTypeLoginClick) forControlEvents:UIControlEventTouchUpInside];
    otherTypeLoginBtn.titleLabel.font = F12;
    [self.view addSubview:otherTypeLoginBtn];
    [otherTypeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(logoImageV.mas_bottom).offset(FITiPhone6(10));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(13)));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CE6E2E2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(otherTypeLoginBtn.mas_bottom).offset(FITiPhone6(7));
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(0.5)));
    }];
    self.telephoneTF = [[UITextField alloc] init];
    self.telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.telephoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.telephoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneTF.placeholder = @"请输入手机号";
    [self.telephoneTF setValue:C989898
              forKeyPath:@"_placeholderLabel.textColor"];
    [self.telephoneTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.telephoneTF.borderStyle = UITextBorderStyleNone;
    self.telephoneTF.font = F13;
    self.telephoneTF.layer.cornerRadius = FITiPhone6(5);
    self.telephoneTF.layer.masksToBounds = YES;
    self.telephoneTF.backgroundColor = CEEEEEE;
    [self.view addSubview:_telephoneTF];
    [_telephoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(lineView.mas_bottom).offset(FITiPhone6(28));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.placeholder = @"请输入密码";
    [self.passwordTF setValue:C989898
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.font = F13;
    self.passwordTF.layer.cornerRadius = FITiPhone6(5);
    self.passwordTF.layer.masksToBounds = YES;
    self.passwordTF.backgroundColor = CEEEEEE;
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.telephoneTF.mas_bottom).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn = loginBtn;
    loginBtn.backgroundColor = C1E95F9;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = FITiPhone6(20);
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.passwordTF.mas_bottom).offset(FITiPhone6(116));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(40)));
    }];
}

#pragma mark ---- 其他方式登录 ----
- (void)otherTypeLoginClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];}
#pragma mark ---- 登录 ----
- (void)loginClick {
    [self.view endEditing:YES];
    _aview = [GlobalMethod addUIActivityIndicator:self.loginBtn];
    
    [[LoginManager getInstance] loginWithAccount:self.telephoneTF.text  andPassword:self.passwordTF.text result:^(BOOL success, NSDictionary *result) {
        [self loginSuccess:success Result:result];
    }];
}


- (void)loginSuccess:(BOOL)success Result:(NSDictionary *)result
{
    [_aview stopAnimating];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    if (success) {
        if ([result[@"msg"] isEqualToString:@"操作成功"]) {
            HUD_SUCCESS(@"登录成功");
            [self performSelector:@selector(changeRoot) withObject:nil afterDelay:1];
            
        }else {
            HUD_TIP(result[@"msg"]);
        }
    }
}

- (void)changeRoot
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    RootViewController *mainViewController=[[RootViewController alloc]init];
    window.rootViewController = mainViewController;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.tabBarController.selectedIndex=0;
        
    }];
}
-(AFHTTPSessionManager*)GetAFHTTPSessionManagerObject{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return session;
}
@end
