//
//  WithdrawCashViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "WithdrawCashViewController.h"
#import "WithdrawCashTableViewCell.h"

@interface WithdrawCashViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *withdrawCashTableView;

@end

@implementation WithdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"立即提现";
    [self initPromptLabel];
    [self createTableView];
    [self createWithdrawBtn];
}
- (void)initPromptLabel {
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"提示：您当前账户余额金为：100";
    promptLabel.textColor = C000000;
    promptLabel.font = F13;
    [self.view addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(35)));
    }];
}

- (void)createTableView {
    _withdrawCashTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITiPhone6(35), ScreenWidth, FITiPhone6(368)) style:UITableViewStylePlain];
    _withdrawCashTableView.backgroundColor = WhiteColor;
    _withdrawCashTableView.delegate = self;
    _withdrawCashTableView.dataSource = self;
    _withdrawCashTableView.showsVerticalScrollIndicator = NO;
    _withdrawCashTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_withdrawCashTableView];
}

- (void)createWithdrawBtn {
    UIButton *withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawBtn.backgroundColor = RGB(210, 210, 210);
    withdrawBtn.frame = CGRectMake(FITiPhone6(15), CGRectGetMaxY(self.withdrawCashTableView.frame) + FITiPhone6(82), ScreenWidth - FITiPhone6(30), FITiPhone6(46));
    [withdrawBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    withdrawBtn.titleLabel.font = F13;
    [withdrawBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [withdrawBtn addTarget:self action:@selector(withdrawClick) forControlEvents:UIControlEventTouchUpInside];
    withdrawBtn.layer.cornerRadius = FITiPhone6(3);
    withdrawBtn.layer.masksToBounds = YES;
    [self.view addSubview:withdrawBtn];
}
#pragma mark ---- 确认提现 ----
- (void)withdrawClick {
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WithdrawCashTableViewCell *cell = [WithdrawCashTableViewCell cellWithTableView:tableView];
    NSArray *titleArray = @[@"持卡人", @"卡号", @"省份", @"分支行", @"手机号", @"金额", @"提取密码", @"身份证"];
    cell.titleLabel.text = titleArray[indexPath.row];
    [cell.contentTF setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    switch (indexPath.row) {
        case 0:{
            cell.contentTF.placeholder = @"请输入您的名字";
        }
            break;
        case 1:{
            cell.contentTF.placeholder = @"请输入银行卡号";
        }
            break;
        case 2:{
            cell.contentTF.hidden = YES;
            cell.citySelectBtn.hidden = NO;
        }
            break;
        case 3:{
            cell.contentTF.placeholder = @"请输入分支行";
        }
            break;
        case 4:{
            cell.contentTF.placeholder = @"请输入手机号";
        }
            break;
        case 5:{
            cell.contentTF.placeholder = @"请输入本次提取金额";
            cell.totalWithdrawBtn.hidden = NO;
        }
            break;
        case 6:{
            cell.contentTF.placeholder = @"请输入您的提取密码";
        }
            break;
        case 7:{
            cell.contentTF.placeholder = @"请输入您的身份证号";
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(46);
}


@end
















