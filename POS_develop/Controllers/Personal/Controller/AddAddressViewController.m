//
//  AddAddressViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AddAddressViewController.h"
#import "BLAreaPickerView.h"//地址选择
@interface AddAddressViewController ()<BLPickerViewDelegate>
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UITextField *detailAddress;
@property (nonatomic, strong) UIButton *defaultAddressBtn;
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
    self.cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.cityBtn.titleLabel.font = F13;
    [self.cityBtn setTitleColor:C989898 forState:UIControlStateNormal];
    [self.cityBtn addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [whiteBgView addSubview:self.cityBtn];
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(line2.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(46)));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = CE6E2E2;
    [whiteBgView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.cityBtn.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(0.5)));
    }];
    self.detailAddress = [[UITextField alloc] init];
    self.detailAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.detailAddress.leftViewMode = UITextFieldViewModeAlways;
    self.detailAddress.placeholder = @"请输入详细地址";
    [self.detailAddress setValue:C989898
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.detailAddress setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.detailAddress.keyboardType = UIKeyboardTypeNumberPad;
    self.detailAddress.borderStyle = UITextBorderStyleNone;
    self.detailAddress.font = F13;
    self.detailAddress.layer.cornerRadius = FITiPhone6(5);
    self.detailAddress.layer.masksToBounds = YES;
    [whiteBgView addSubview:_detailAddress];
    [_detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(line3.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(46)));
    }];
    self.defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.defaultAddressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.defaultAddressBtn setTitle:@"设置为默认地址" forState:UIControlStateNormal];
    [self.defaultAddressBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.defaultAddressBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(23)];
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认"] forState:normal];
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认地址"] forState:UIControlStateSelected];
    [self.defaultAddressBtn addTarget:self action:@selector(defaultAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    self.defaultAddressBtn.titleLabel.font = F12;
    [self.view addSubview:self.defaultAddressBtn];
    [self.defaultAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(25));
        make.top.equalTo(whiteBgView.mas_bottom).offset(FITiPhone6(15));
        make.size.sizeOffset(CGSizeMake(ScreenWidth, FITiPhone6(15)));
    }];
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = CC9C9C9;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = FITiPhone6(3);
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.defaultAddressBtn.mas_bottom).offset(FITiPhone6(61));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
}

#pragma mark ---- 设置为默认地址 ----
- (void)defaultAddressClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
#pragma mark ---- 保存 ----
- (void)saveClick {
    
}
#pragma mark ---- 选择地址 ----
- (void)selectAddress
{
    //地址
    BLAreaPickerView *pickerV = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    pickerV.pickViewDelegate = self;
    [pickerV bl_show];
}


#pragma mark ---- BLPickerViewDelegate ----
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle region_id:(NSString *)region_id{
    
//    self.regin_id = region_id;
    [self.cityBtn setTitle:[NSString stringWithFormat:@"%@%@%@",provinceTitle,cityTitle,areaTitle] forState:normal];
    [self.cityBtn setTitleColor:C000000 forState:normal];
}
@end










