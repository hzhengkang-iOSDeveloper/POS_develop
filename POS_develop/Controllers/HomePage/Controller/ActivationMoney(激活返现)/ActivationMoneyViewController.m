//
//  ActivationMoneyViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ActivationMoneyViewController.h"
#import "DatePickerView.h"
#import "ActivationMoneyDetailViewController.h"

@interface ActivationMoneyViewController ()
@property (nonatomic, strong) UIButton *agentBtn;
@property (nonatomic, strong) UIButton *personBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation ActivationMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"激活返现查询";
    self.view.backgroundColor = WhiteColor;
    [self initUI];
}

- (void)initUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = CF6F6F6;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(121)));
    }];
    UIButton *dateSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateSelectBtn setTitle:@"日期选择" forState:UIControlStateNormal];
    [dateSelectBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [dateSelectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(7)];
    [dateSelectBtn setImage:[UIImage imageNamed:@"日期选择"] forState:normal];
    dateSelectBtn.titleLabel.font = F13;
    dateSelectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:dateSelectBtn];
    [dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(AD_HEIGHT(15));
        make.top.equalTo(self.view).offset(AD_HEIGHT(21));
        make.height.mas_offset(AD_HEIGHT(13));
    }];
    DatePickerView *datePickView = [[DatePickerView alloc] init];
    [bgView addSubview:datePickView];
    [datePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(dateSelectBtn.mas_bottom).offset(AD_HEIGHT(27));
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(29)));
    }];
    
    self.agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.agentBtn setTitle:@"代理商" forState:UIControlStateNormal];
    [self.agentBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.agentBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(13)];
    [self.agentBtn setImage:[UIImage imageNamed:@"勾选"] forState:normal];
    [self.agentBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.agentBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agentBtn.titleLabel.font = F12;
    //    self.agentBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.agentBtn];
    [self.agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AD_HEIGHT(100));
        make.left.equalTo(self.view).offset(AD_HEIGHT(15));
        make.top.equalTo(bgView.mas_bottom).offset(AD_HEIGHT(78));
        make.height.mas_offset(AD_HEIGHT(25));
    }];
    
    self.personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.personBtn setTitle:@"个人" forState:UIControlStateNormal];
    [self.personBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(13)];
    [self.personBtn setImage:[UIImage imageNamed:@"勾选"] forState:normal];
    [self.personBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.personBtn addTarget:self action:@selector(personClick:) forControlEvents:UIControlEventTouchUpInside];
    self.personBtn.titleLabel.font = F12;
    //    self.personBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.personBtn];
    [self.personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AD_HEIGHT(100));
        make.right.equalTo(self.view).offset(AD_HEIGHT(-100));
        make.top.equalTo(bgView.mas_bottom).offset(AD_HEIGHT(78));
        make.height.mas_offset(AD_HEIGHT(25));
    }];
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.backgroundColor = C1E95F9;
    [self.selectBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.selectBtn.layer.cornerRadius = FITiPhone6(3);
    self.selectBtn.layer.masksToBounds = YES;
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.personBtn.mas_bottom).offset(FITiPhone6(49));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
    
    
    
}
- (void)agentClick:(UIButton *)sender {
    if (_agentBtn.selected) {
        
    }
    else if (!_agentBtn.selected)
    {
        _agentBtn.selected = YES;
        _personBtn.selected = NO;
    }
    NSLog(@"代理");
}
- (void)personClick:(UIButton *)sender {
    if (_personBtn.selected) {
        
    }
    else if (!_personBtn.selected)
    {
        _personBtn.selected = YES;
        _agentBtn.selected = NO;
    }
    NSLog(@"个人");
}
#pragma mark ---- 查询 ----
- (void)selectClick {
    ActivationMoneyDetailViewController *vc = [[ActivationMoneyDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
