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

@interface WithdrawCashViewController () <UITableViewDataSource, UITableViewDelegate, BLPickerViewDelegate>
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
    
    [cell.citySelectBtn setTitleColor:C000000 forState:normal];
   
}


#pragma mark ---- 接口 ----
- (void)loadBagWithdrawListRequest {
//    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagWithdraw/list" params:@{@"userid":@"1", @"defaultFlag":sender.selected?@0:@1, @"id":ID} cookie:nil result:^(bool success, id result) {
//        [self.myAddressTableView reloadData];
//        NSLog(@"result ------- %@", result);
//    }];
}

#pragma mark ---- 提现 ----
- (void)loadBagWithdrawSaveRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagWithdraw/save" params:@{@"userid":@"1", @"bankUser":@"", @"bankUserNo":@"", @"bankProvince":@"", @"bankCity":@"", @"bankBranchName":@"", @"bankUserMp":@"", @"amount":@"", @"withDrawPasswd":@"", @"bankUserId":@""} cookie:nil result:^(bool success, id result) {
        
        NSLog(@"result ------- %@", result);
    }];
}
@end
















