//
//  PasswordLoginViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "AFNetworking.h"

@interface PasswordLoginViewController ()
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UITextField *passwordTF;
@end

@implementation PasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---- 登录 ----
- (void)loginClick {
//    [[HPDConnect connect] webservicesAFNetPOSTMethod:@"login" params:@{@"mobile":self.telephoneTF.text, @"password":self.passwordTF.text} cookie:[[LoginManager getInstance] userCookie] result:^(bool success, id result) {
//
//        NSLog(@"%@", result);
//    }];
    
    
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    NSDictionary *dit = @{@"mobile":self.telephoneTF.text, @"password":self.passwordTF.text};
    [session POST:@"http://106.14.7.85:8000/login"  parameters:dit success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
//        result(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (![self wasNetworkValid]) {
//            [SVProgressHUD showInfoWithStatus:@"网络繁忙，请稍后~"];
//#if DEBUG
//            NSLog(@"--->net work can not used!");
//#endif
//            result(NO, nil);
//            return;
//        }
//        result(NO,error);
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
