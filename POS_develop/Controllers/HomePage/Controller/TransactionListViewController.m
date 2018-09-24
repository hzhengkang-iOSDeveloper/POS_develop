//
//  TransactionListViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionListViewController.h"
#import "TransactionListCell.h"
#import "TransactionDetailViewController.h"

@interface TransactionListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *transactionListTableView;
@end

@implementation TransactionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"交易流水";
    
    [self createTableView];
}

- (void)createTableView {
    _transactionListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _transactionListTableView.backgroundColor = WhiteColor;
    _transactionListTableView.delegate = self;
    _transactionListTableView.dataSource = self;
    _transactionListTableView.showsVerticalScrollIndicator = NO;
    _transactionListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_transactionListTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionListCell *cell = [TransactionListCell cellWithTableView:tableView];
    cell.nameLabel.text = @"个体户-陈丽娜";
    cell.timeLabel.text = @"2018/1/7-2018/1/18";
    cell.amountLabel.text = @"+3000元";
    cell.snLabel.text = @"SN:7300000000";
    cell.seeDetailBlock = ^{
        TransactionDetailViewController *vc = [[TransactionDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(87);
}

@end
