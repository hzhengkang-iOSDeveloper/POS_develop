//
//  MyAddressEditViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/14.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "MyAddressEditViewController.h"
#import "BLAreaPickerView.h"//地址选择
#import "MyAddressViewModel.h"
@interface MyAddressEditViewController ()<BLPickerViewDelegate>
{
    NSInteger count;
    NSString *province;
    NSString *city;
    NSString *county;
}
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UITextField *detailAddress;
@property (nonatomic, strong) UIButton *defaultAddressBtn;
@property (nonatomic, strong)  UIButton *saveBtn;

@end

@implementation MyAddressEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"编辑地址";
    count = 1;
    province = self.addressM.province;
    city = self.addressM.city;
    county = self.addressM.county;
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
    self.nameTF.text = self.addressM.receiverName;
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
    [self.nameTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
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
    self.telephoneTF.text = self.addressM.receiverMp;
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
    [self.telephoneTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
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
    [self.cityBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", self.addressM.province, self.addressM.city, self.addressM.county] forState:UIControlStateNormal];
    self.cityBtn.titleLabel.font = F13;
    [self.cityBtn setTitleColor:C000000 forState:UIControlStateNormal];
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
    self.detailAddress.text = self.addressM.receiverAddr;
    self.detailAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.detailAddress.leftViewMode = UITextFieldViewModeAlways;
    self.detailAddress.placeholder = @"请输入详细地址";
    [self.detailAddress setValue:C989898
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.detailAddress setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.detailAddress.borderStyle = UITextBorderStyleNone;
    self.detailAddress.font = F13;
    self.detailAddress.layer.cornerRadius = FITiPhone6(5);
    self.detailAddress.layer.masksToBounds = YES;
    [self.detailAddress addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [whiteBgView addSubview:_detailAddress];
    [_detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(line3.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(46)));
    }];
    
    self.defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [self.defaultAddressBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.defaultAddressBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(23)];
    if ([self.addressM.defaultFlag isEqualToString:@"0"]) {
        self.defaultAddressBtn.selected = YES;
    }else {
        self.defaultAddressBtn.selected = NO;
    }
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认"] forState:normal];
    [self.defaultAddressBtn setImage:[UIImage imageNamed:@"默认地址"] forState:UIControlStateSelected];
    [self.defaultAddressBtn addTarget:self action:@selector(defaultAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    self.defaultAddressBtn.titleLabel.font = F12;
    [self.view addSubview:self.defaultAddressBtn];
    [self.defaultAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(FITiPhone6(25));
        make.top.equalTo(whiteBgView.mas_bottom).offset(FITiPhone6(15));
        make.size.sizeOffset(CGSizeMake(FITiPhone6(90), FITiPhone6(15)));
    }];
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.backgroundColor = C1E95F9;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = FITiPhone6(3);
    self.saveBtn.layer.masksToBounds = YES;
    [self.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.defaultAddressBtn.mas_bottom).offset(FITiPhone6(61));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
}

#pragma mark ---- 设置为默认地址 ----
- (void)defaultAddressClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark ---- 选择地址 ----
- (void)selectAddress
{
    [self.view endEditing:YES];
    //地址
    BLAreaPickerView *pickerV = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    pickerV.pickViewDelegate = self;
    [pickerV bl_show];
}


#pragma mark ---- BLPickerViewDelegate ----
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle region_id:(NSString *)region_id{
    
    //    self.regin_id = region_id;
    [self.cityBtn setTitle:[NSString stringWithFormat:@"%@%@%@",provinceTitle,cityTitle,areaTitle] forState:normal];
    province = provinceTitle;
    city = cityTitle;
    county = areaTitle;
    
    self.addressM.province = province;
    self.addressM.city = city;
    self.addressM.county = county;
    
    [self.cityBtn setTitleColor:C000000 forState:normal];
    count = 1;
    if (self.nameTF.text.length > 0 && self.telephoneTF.text.length > 0 && self.detailAddress.text.length > 0) {
        self.saveBtn.userInteractionEnabled = YES;
        self.saveBtn.backgroundColor = C1E95F9;
    }
}


- (void)textFieldEditChanged:(UITextField *)textField

{
    if (self.nameTF.text.length > 0 && self.telephoneTF.text.length > 0 && self.detailAddress.text.length > 0 && count ==1) {
        self.saveBtn.userInteractionEnabled = YES;
        self.saveBtn.backgroundColor = C1E95F9;
        
    }else {
        
        self.saveBtn.userInteractionEnabled = NO;
        self.saveBtn.backgroundColor = CC9C9C9;
    }
    NSLog(@"textfield.text %@",textField.text);
    
    
    
}


#pragma mark ---- 接口 ----

#pragma mark ---- 保存 ----
- (void)saveClick {
    if (self.telephoneTF.text.length != 11) {
        HUD_TIP(@"请输入11位手机号");
        return;
    }
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/address/update" params:@{@"userid":IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:USERID]), @"defaultFlag":self.defaultAddressBtn.selected?@0:@1, @"receiverName":IF_NULL_TO_STRING(self.nameTF.text), @"receiverMp":IF_NULL_TO_STRING(self.telephoneTF.text), @"province" : province, @"city" : city, @"county": county, @"receiverAddr":self.detailAddress.text, @"id":self.addressM.ID} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"msg"] isEqualToString:@"success"]) {
                self.addressM.defaultFlag = self.defaultAddressBtn.selected?@"0":@"1";
                self.addressM.receiverName = self.nameTF.text;
                self.addressM.receiverMp = self.telephoneTF.text;
                self.addressM.receiverAddr = self.detailAddress.text;
                HUD_TIP(@"保存成功");
                [self.navigationController popViewControllerAnimated:YES];
                if (self.updateAddressList) {
                    self.updateAddressList(self.addressM);
                }
            }
            
        }
        
        NSLog(@"result ------- %@", result);
    }];
    
}
@end
