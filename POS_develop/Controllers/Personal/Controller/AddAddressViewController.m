//
//  AddAddressViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UITextField *detailAddress;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增地址";
    [self initUI];
}

- (void)initUI {
    UIView *whiteBgView = [[UIView alloc] init];
    whiteBgView.backgroundColor = WhiteColor;
    [self.view addSubview:whiteBgView];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(186)));
    }];
    self.nameTF = [[UITextField alloc] init];
    self.nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTF.placeholder = @"请输入收货人姓名";
    [self.nameTF setValue:C989898
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.nameTF.borderStyle = UITextBorderStyleNone;
    self.nameTF.font = F13;
    self.nameTF.layer.cornerRadius = FITiPhone6(5);
    self.nameTF.layer.masksToBounds = YES;
//    self.nameTF.backgroundColor = WhiteColor;
    [whiteBgView addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(45)));
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = CE6E2E2;
    [whiteBgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.nameTF.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(0.5)));
    }];
    self.telephoneTF = [[UITextField alloc] init];
    self.telephoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.telephoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneTF.placeholder = @"请输入收货人手机号";
    [self.telephoneTF setValue:C989898
               forKeyPath:@"_placeholderLabel.textColor"];
    [self.telephoneTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.telephoneTF.borderStyle = UITextBorderStyleNone;
    self.telephoneTF.font = F13;
    self.telephoneTF.layer.cornerRadius = FITiPhone6(5);
    self.telephoneTF.layer.masksToBounds = YES;
//    self.telephoneTF.backgroundColor = WhiteColor;
    [whiteBgView addSubview:_telephoneTF];
    [_telephoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(line1.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(46)));
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = CE6E2E2;
    [whiteBgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.telephoneTF.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(0.5)));
    }];
    self.cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
}

@end
