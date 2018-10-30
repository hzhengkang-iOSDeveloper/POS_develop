//
//  RegisterViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController () {
}
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *codeTimeBtn;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *recommendTF;
@property (nonatomic, strong) UILabel *recommendL;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeSum;
@property (nonatomic, strong) UIActivityIndicatorView *aview;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"我要注册";
    self.view.backgroundColor = WhiteColor;
    NSLog(@"%@", [HDeviceIdentifier deviceIdentifier]);
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
    self.codeTF = [[UITextField alloc] init];
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
    
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.placeholder = @"请输入密码（8-16位）";
    [self.passwordTF setValue:C989898
               forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.font = F13;
    self.passwordTF.layer.cornerRadius = FITiPhone6(5);
    self.passwordTF.layer.masksToBounds = YES;
    self.passwordTF.backgroundColor = CEEEEEE;
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.telephoneTF.mas_bottom).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(41)));
    }];
    self.recommendTF = [[UITextField alloc] init];
    self.recommendTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.recommendTF.leftViewMode = UITextFieldViewModeAlways;
    self.recommendTF.placeholder = @"请输入推荐码或者推荐人手机号";
    [self.recommendTF setValue:C989898
                   forKeyPath:@"_placeholderLabel.textColor"];
    [self.recommendTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.recommendTF.keyboardType = UIKeyboardTypeNumberPad;
    self.recommendTF.borderStyle = UITextBorderStyleNone;
    self.recommendTF.font = F13;
    self.recommendTF.layer.cornerRadius = FITiPhone6(5);
    self.recommendTF.layer.masksToBounds = YES;
    self.recommendTF.backgroundColor = CEEEEEE;
    [self.view addSubview:self.recommendTF];
    [self.recommendTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.passwordTF.mas_bottom).offset(FITiPhone6(18));
        make.size.mas_offset(CGSizeMake(FITiPhone6(252), FITiPhone6(41)));
    }];
    self.recommendL = [[UILabel alloc] init];
    self.recommendL.text = @"推荐人xxx";
    self.recommendL.textColor = C000000;
    self.recommendL.font = F13;
    [self.view addSubview:self.recommendL];
    [self.recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recommendTF.mas_right).offset(FITiPhone6(16));
        make.centerY.equalTo(self.recommendTF.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(100), FITiPhone6(13)));
    }];
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.backgroundColor = C1E95F9;
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.registerBtn.layer.cornerRadius = FITiPhone6(20);
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.recommendTF.mas_bottom).offset(FITiPhone6(59));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(40)));
    }];
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"图层4拷贝"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(34));
        make.top.equalTo(self.registerBtn.mas_bottom).offset(FITiPhone6(16));
        make.size.mas_offset(CGSizeMake(FITiPhone6(15), FITiPhone6(15)));
    }];
    UILabel *agreeL = [[UILabel alloc] init];
    agreeL.text = @"我同意“服务条款”和“隐私权相关政策”";
    agreeL.textColor = C000000;
    agreeL.font = F12;
    [self.view addSubview:agreeL];
    [agreeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right).offset(FITiPhone6(6));
        make.centerY.equalTo(self.selectBtn.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(250), FITiPhone6(13)));
    
    }];

}
//注册协议选择按钮
- (void)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
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
    [[HPDConnect connect] GetNetRequestMethod:[NSString stringWithFormat:@"register/getsmscode?mobile=%@",self.telephoneTF.text] params:nil cookie:nil result:^(bool success, id result) {
        [self.aview stopAnimating];
        if (success) {
            if ([result[@"msg"] isEqualToString:@"操作成功"]) {
                self.timeSum = 60;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
                self.codeTimeBtn.userInteractionEnabled = NO;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.passwordTF) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.passwordTF.text.length > 16) {
            self.passwordTF.text = [textField.text substringToIndex:16];
            return NO;
        }
    }
    
    return YES;
}


#pragma mark ---- 其他方式登录 ----
- (void)otherTypeLoginClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---- 注册 ----
- (void)registerClick {
    [self.view endEditing:YES];
    _aview = [GlobalMethod addUIActivityIndicator:self.registerBtn];
    if (self.passwordTF.text.length<8) {
        HUD_TIP(@"密码不能小于8位");
        return;
    }
    if (!self.selectBtn.selected) {
        HUD_TIP(@"请先同意“服务条款”和“隐私权相关政策”");
        return;
    }
    [[HPDConnect connect] PostNetRequestMethod:@"register" params:@{@"deviceId":[HDeviceIdentifier deviceIdentifier], @"invitedCode":self.recommendTF.text, @"mobile":self.passwordTF.text, @"password":self.passwordTF.text, @"smsCode":self.codeTF.text} cookie:nil result:^(bool success, id result) {
        [self.aview stopAnimating];
        [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        if (success) {
            
        }
        
        
        
    }];

    
}


@end
