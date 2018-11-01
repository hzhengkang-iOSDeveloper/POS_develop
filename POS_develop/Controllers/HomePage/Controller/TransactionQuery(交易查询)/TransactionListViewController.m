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
#import "TransactionListModel.h"

@interface TransactionListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *transactionListTableView;
@end

@implementation TransactionListViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"交易流水";
    [self createTableView];
    
}

- (void)createTableView {
    _transactionListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _transactionListTableView.backgroundColor = WhiteColor;
    _transactionListTableView.delegate = self;
    _transactionListTableView.dataSource = self;
    _transactionListTableView.showsVerticalScrollIndicator = NO;
    _transactionListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _transactionListTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    [self.view addSubview:_transactionListTableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionListCell *cell = [TransactionListCell cellWithTableView:tableView];
    TransactionListModel *model = self.dataArray[indexPath.row];
    cell.model = model;

    cell.seeDetailBlock = ^{
        TransactionDetailViewController *vc = [[TransactionDetailViewController alloc] init];
        vc.myID = model.ID;
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
