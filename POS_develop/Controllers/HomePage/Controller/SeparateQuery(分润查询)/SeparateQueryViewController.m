
//
//  SeparateQueryViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryViewController.h"
#import "DatePickerView.h"
#import "SeparateQueryMainView.h"
#import "SeparateQueryDetailViewController.h"


@interface SeparateQueryViewController ()
@property (nonatomic, strong) UIButton *agentBtn;
@property (nonatomic, strong) UIButton *personBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) DatePickerView *datePickView;
@property (nonatomic, strong) SeparateQueryMainView *mainView;

@property (nonatomic, assign) BOOL isSelectDate;
@property (nonatomic, assign) BOOL isSelectAgentOrPerson;

@end

@implementation SeparateQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分润查询";
    self.isSelectDate = NO;
    self.isSelectAgentOrPerson = NO;
    
    [self initUI];
}

- (void)initUI {
    UIButton *dateSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateSelectBtn setTitle:@"日期选择" forState:UIControlStateNormal];
    [dateSelectBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [dateSelectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(7)];
    [dateSelectBtn setImage:[UIImage imageNamed:@"日期选择"] forState:normal];
    dateSelectBtn.titleLabel.font = F13;
    dateSelectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:dateSelectBtn];
    [dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(AD_HEIGHT(15));
        make.top.offset(0);
        make.height.mas_offset(AD_HEIGHT(31));
    }];
    MJWeakSelf;
    DatePickerView *datePickView = [[DatePickerView alloc] init];
    datePickView.clcikDateSelected = ^(BOOL isSelected) {
        weakSelf.isSelectDate = YES;
    };
    datePickView.backVcChangeBtn = ^{
        [weakSelf.selectBtn setBackgroundColor:C1E95F9];
        weakSelf.selectBtn.userInteractionEnabled = YES;
    };
    self.datePickView = datePickView;
    [self.view addSubview:datePickView];
    [datePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(dateSelectBtn.mas_bottom).offset(-5);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    SeparateQueryMainView *mainView = [[[NSBundle mainBundle] loadNibNamed:@"SeparateQueryMainView" owner:self options:nil] lastObject];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(datePickView.mas_bottom).offset(AD_HEIGHT(8));
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 154));
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
        make.top.equalTo(mainView.mas_bottom).offset(AD_HEIGHT(22));
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
        make.top.equalTo(mainView.mas_bottom).offset(AD_HEIGHT(22));
        make.height.mas_offset(AD_HEIGHT(25));
    }];
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.backgroundColor = CC9C9C9;
    self.selectBtn.userInteractionEnabled = NO;
    [self.selectBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.selectBtn.layer.cornerRadius = FITiPhone6(3);
    self.selectBtn.layer.masksToBounds = YES;
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.personBtn.mas_bottom).offset(FITiPhone6(40));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
    
}

- (void)agentClick:(UIButton *)sender {
    if (!_agentBtn.selected)
    {
        _agentBtn.selected = YES;
        _personBtn.selected = NO;
    }
    
    
    [self changeSelectBtn];
}
- (void)personClick:(UIButton *)sender {
    if (!_personBtn.selected)
    {
        _personBtn.selected = YES;
        _agentBtn.selected = NO;
    }
    [self changeSelectBtn];
}
#pragma mark ---- 按钮显示逻辑 ----
- (void)changeSelectBtn
{
    if (!self.isSelectDate) {
        self.datePickView.agentOrPersonIsSelected = YES;
    } else {
        [self.selectBtn setBackgroundColor:C1E95F9];
        self.selectBtn.userInteractionEnabled = YES;
    }
}
#pragma mark ---- 查询 ----
- (void)selectClick {
    SeparateQueryDetailViewController *vc = [[SeparateQueryDetailViewController alloc] init];
    vc.startTime = self.datePickView.datePickerStrA;
    vc.endTime = self.datePickView.datePickerStrB;
    vc.agentName = self.mainView.name.text;
    vc.agentNo = self.mainView.account.text;
    vc.agentType = _agentBtn.selected?@"1":@"0";
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end














