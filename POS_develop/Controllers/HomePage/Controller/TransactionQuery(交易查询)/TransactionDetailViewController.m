//
//  TransactionDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "TransactionDetailCell.h"
#import "TransactionListModel.h"

@interface TransactionDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *transactionDetailTableView;
@property (nonatomic, strong) NSDictionary *dataDict;


@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDict = [NSDictionary dictionary];
    [self createTableView];
    [self loadPosBrandRequest];
}

- (void)createTableView {
    _transactionDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _transactionDetailTableView.backgroundColor = WhiteColor;
    _transactionDetailTableView.delegate = self;
    _transactionDetailTableView.dataSource = self;
    _transactionDetailTableView.showsVerticalScrollIndicator = NO;
    _transactionDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_transactionDetailTableView];
    [_transactionDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionDetailCell *cell = [TransactionDetailCell cellWithTableView:tableView];
    cell.titleLabel.text = [self.dataDict objectForKey:@"agentName"];
    cell.timeLabel.text = [self.dataDict objectForKey:@"transTime"];
    if ([[self.dataDict objectForKey:@"transAmount"] intValue] > 0) {
        cell.amountLabel.text = [NSString stringWithFormat:@"+%@",[self.dataDict objectForKey:@"transAmount"]];
    }else {
        cell.amountLabel.text = [self.dataDict objectForKey:@"transAmount"];
    }
    cell.statusLabel.text = [self.dataDict objectForKey:@"transResult"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(50);
}

#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- 交易查询详情 ----
- (void)loadPosBrandRequest {
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@", @"api/trans/transaction/get/", self.myID] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    self.dataDict = result[@"data"];
                    self.navigationItemTitle = [self.dataDict objectForKey:@"agentName"];
                    [self.transactionDetailTableView reloadData];
                    
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end



























