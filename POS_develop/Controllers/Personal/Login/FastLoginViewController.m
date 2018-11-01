//
//  FastLoginViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "FastLoginViewController.h"

@interface FastLoginViewController () {
    
}
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *codeTimeBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeSum;
@property (nonatomic, strong) UIActivityIndicatorView *aview;
@end

@implementation FastLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPop = YES;
    self.navigationItemTitle = @"手机号快捷登录";
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
//    self.telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
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
    self.codeTF = [[UITextField alloc] init];
    self.codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.secureTextEntry = YES;
    self.codeTF.placeholder = @"请输入短信验证码";
    [self.codeTF setValue:C989898
                   forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.borderStyle = UITextBorderStyleNone;
    self.codeTF.font = F13;
    self.codeTF.layer.cornerRadius = FITiPhone6(5);
    self.codeTF.layer.masksToBounds = YES;
    self.codeTF.backgroundColor = CEEEEEE;
    [self.view addSubview:_codeTF];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.telephoneTF.mas_bottom).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
    self.codeTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeTimeBtn setTitle:@"验证码" forState:UIControlStateNormal];
    self.codeTimeBtn.titleLabel.font = F12;
    [self.codeTimeBtn setTitleColor:C1E95F9 forState:UIControlStateNormal];
    self.codeTimeBtn.layer.cornerRadius = FITiPhone6(13);
    self.codeTimeBtn.layer.masksToBounds = YES;
    self.codeTimeBtn.layer.borderColor = C1E95F9.CGColor;
    self.codeTimeBtn.layer.borderWidth = FITiPhone6(0.5);
    [self.codeTimeBtn addTarget:self action:@selector(requestForVertifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeTimeBtn];
    [self.codeTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.telephoneTF.mas_right).offset(FITiPhone6(-8));
        make.centerY.equalTo(self.telephoneTF.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(69), FITiPhone6(25)));
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
        make.top.equalTo(self.codeTF.mas_bottom).offset(FITiPhone6(116));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(40)));
    }];
}
#pragma mark 获取短信验证码
- (void)requestForVertifyCode{
    [self.view endEditing:YES];
    if (![[self.telephoneTF textContainsNoCharset] isPhoneNumberFormat]) {
        [self.telephoneTF becomeFirstResponder];
        HUD_TIP(@"请输入正确的手机号");
        return;
    }
    _aview = [GlobalMethod addUIActivityIndicator:self.codeTimeBtn];
    //MARK: 接口获取短信验证码
    [[HPDConnect connect] GetNetRequestMethod:[NSString stringWithFormat:@"login/getsmscode?mobile=%@", self.telephoneTF.text] params:nil cookie:nil result:^(bool success, id result) {
        [self.aview stopAnimating];
        [self.codeTimeBtn setTitle:@"重发" forState:UIControlStateNormal];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                self.timeSum = 60;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
                self.codeTimeBtn.userInteractionEnabled = NO;
            }else{
                HUD_TIP(result[@"msg"]);
            }
        }
        
    }];

}
-(void)timerChange:(NSTimer*)timer
{
    self.timeSum-=1;
    [self.codeTimeBtn setTitle:[NSString stringWithFormat:@"(%dS)",self.timeSum] forState:0];
    if (self.timeSum<=0) {
        [timer invalidate];
        [self.codeTimeBtn setTitle:@"重发" forState:UIControlStateNormal];
        self.codeTimeBtn.userInteractionEnabled = YES;

    }
}
#pragma mark ---- 其他方式登录 ----
- (void)otherTypeLoginClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark ---- 登录 ----
- (void)loginClick {
    [self.view endEditing:YES];
    _aview = [GlobalMethod addUIActivityIndicator:self.loginBtn];
    [[LoginManager getInstance]loginFastWithAccount:self.telephoneTF.text andSmsCode:self.codeTF.text result:^(BOOL success, NSDictionary *result) {
        [self.aview stopAnimating];
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        if (success) {
//            if ([result[@"code"]integerValue] == 0) {
//                <#statements#>
//            }
            HUD_SUCCESS(@"登录成功");
            [self performSelector:@selector(changeRoot) withObject:nil afterDelay:1];

            
        } else {
            HUD_ERROR(@"操作异常请稍后重试！");
        }
    }];
   
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
@end
