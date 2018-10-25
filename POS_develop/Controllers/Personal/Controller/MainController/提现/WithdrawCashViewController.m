//
//  WithdrawCashViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "WithdrawCashViewController.h"
#import "WithdrawCashTableViewCell.h"
#import "BLAreaPickerView.h"
#import "WithdrawCashRecordViewController.h"

@interface WithdrawCashViewController () <UITableViewDataSource, UITableViewDelegate, BLPickerViewDelegate> {
    NSString *bankUser;
    NSString *bankUserNo;
    NSString *bankProvince;
    NSString *bankCity;
    NSString *bankBranchName;
    NSString *bankUserMp;
    NSString *amount;
    NSString *withDrawPasswd;
    NSString *bankUserId;
}
@property (nonatomic, strong) UITableView *withdrawCashTableView;

@end

@implementation WithdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"立即提现";
    [self addStandardRightButtonWithTitle:@"提现记录" selector:@selector(withdrawCashRecord)];
    [self initPromptLabel];
    [self createTableView];
    [self createWithdrawBtn];
//    [self loadBagWithdrawListRequest];
}
#pragma mark ---- 提现记录 ----
- (void)withdrawCashRecord {
    WithdrawCashRecordViewController *vc = [[WithdrawCashRecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initPromptLabel {
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = [NSString stringWithFormat:@"提示：您当前账户余额金为：%@", self.balanceStr];
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
    withdrawBtn.backgroundColor = C1E95F9;
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
    NSIndexPath *path0=[NSIndexPath indexPathForRow:0 inSection:0];
    WithdrawCashTableViewCell *cell0 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path0];
    if ([cell0.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入您的名字");
        return;
    }
    NSIndexPath *path1=[NSIndexPath indexPathForRow:1 inSection:0];
    WithdrawCashTableViewCell *cell1 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path1];
    if ([cell1.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入银行卡号");
        return;
    }
    NSIndexPath *path2=[NSIndexPath indexPathForRow:2 inSection:0];
    WithdrawCashTableViewCell *cell2 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path2];
    if ([cell2.citySelectBtn.titleLabel.text isEqualToString:@"请选择省份城市"]) {
        HUD_TIP(@"请选择省份城市");
        return;
    }
    NSIndexPath *path3=[NSIndexPath indexPathForRow:3 inSection:0];
    WithdrawCashTableViewCell *cell3 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path3];
    if ([cell3.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入分支行");
        return;
    }
    NSIndexPath *path4=[NSIndexPath indexPathForRow:4 inSection:0];
    WithdrawCashTableViewCell *cell4 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path4];
    if ([cell4.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入手机号");
        return;
    }
    NSIndexPath *path5=[NSIndexPath indexPathForRow:5 inSection:0];
    WithdrawCashTableViewCell *cell5 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path5];
    if ([cell5.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入本次提取金额");
        return;
    }
    NSIndexPath *path6=[NSIndexPath indexPathForRow:6 inSection:0];
    WithdrawCashTableViewCell *cell6 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path6];
    if ([cell6.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入您的提取密码");
        return;
    }
    NSIndexPath *path7=[NSIndexPath indexPathForRow:7 inSection:0];
    WithdrawCashTableViewCell *cell7 = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path7];
    if ([cell7.contentTF.text isEqualToString:@""]) {
        HUD_TIP(@"请输入您的身份证号");
        return;
    }
    
    
    bankUser = cell0.contentTF.text;
    bankUserNo = cell1.contentTF.text;
    bankBranchName = cell3.contentTF.text;
    bankUserMp = cell4.contentTF.text;
    amount = cell5.contentTF.text;
    withDrawPasswd = cell6.contentTF.text;
    bankUserId = cell7.contentTF.text;
    
    [self loadBagWithdrawSaveRequest];
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
//    [cell.contentTF setValue:C989898 forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [cell.contentTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    switch (indexPath.row) {
        case 0:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的名字" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
        }
            break;
        case 1:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入银行卡号" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
        }
            break;
        case 2:{
            cell.contentTF.hidden = YES;
            cell.citySelectBtn.hidden = NO;
        }
            break;
        case 3:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入分支行" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
        }
            break;
        case 4:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
        }
            break;
        case 5:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入本次提取金额" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
            cell.totalWithdrawBtn.hidden = NO;
            __weak typeof(cell) weakCell = cell;
            MJWeakSelf
            cell.totalWithdrawClickBlock = ^{
                weakCell.contentTF.text = weakSelf.balanceStr;
            };
        }
            break;
        case 6:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的提取密码" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
        }
            break;
        case 7:{
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的身份证号" attributes:
                                              @{NSForegroundColorAttributeName:C989898,
                                                NSFontAttributeName:cell.contentTF.font
                                                }];
            cell.contentTF.attributedPlaceholder = attrString;
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
    if (indexPath.row == 2) {
        [self selectAddress];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(46);
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
    
    NSIndexPath *path=[NSIndexPath indexPathForRow:2 inSection:0];
    WithdrawCashTableViewCell *cell = (WithdrawCashTableViewCell *)[_withdrawCashTableView cellForRowAtIndexPath:path];
    
    //    self.regin_id = region_id;
    [cell.citySelectBtn setTitle:[NSString stringWithFormat:@"%@%@%@",provinceTitle,cityTitle,areaTitle] forState:normal];
    bankProvince = provinceTitle;
    bankCity = cityTitle;
    [cell.citySelectBtn setTitleColor:C000000 forState:normal];
   
}


#pragma mark ---- 接口 ----

#pragma mark ---- 提现 ----
- (void)loadBagWithdrawSaveRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagWithdraw/save" params:@{@"userid":@"1", @"bankUser":bankUser, @"bankUserNo":bankUserNo, @"bankProvince":bankProvince, @"bankCity":bankCity, @"bankBranchName":bankBranchName, @"bankUserMp":bankUserMp, @"amount":amount, @"withDrawPasswd":withDrawPasswd, @"bankUserId":bankUserId} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"msg"] isEqualToString:@"success"]) {
                HUD_TIP(@"提现成功");
                if (self.popBlock) {
                    self.popBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
















