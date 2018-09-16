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
    self.title = @"立即提现";
    [self createTableView];
    
}
- (void)createTableView {
    _withdrawCashTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITiPhone6(35), ScreenWidth, ScreenHeight - FITiPhone6(35)) style:UITableViewStylePlain];
    _withdrawCashTableView.backgroundColor = WhiteColor;
    _withdrawCashTableView.delegate = self;
    _withdrawCashTableView.dataSource = self;
    _withdrawCashTableView.showsVerticalScrollIndicator = NO;
    _withdrawCashTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_withdrawCashTableView];
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
    
//    if (indexPath.row == 1) {
//        cell.lineView.hidden = NO;
//        cell.getCodeBtn.hidden = NO;
//    }else {
//        cell.lineView.hidden = YES;
//        cell.getCodeBtn.hidden = YES;
//    }
//    NSArray *titleArray = @[@"原手机号", @"新手机号", @"验证码"];
//    NSArray *contentArray = @[@"请输入原手机号", @"请输入新手机号", @"请输入验证码"];
//    cell.titleLabel.text = titleArray[indexPath.row];
//    cell.contentTF.placeholder = contentArray[indexPath.row];
//    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(50);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
