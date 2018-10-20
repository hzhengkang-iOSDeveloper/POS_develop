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
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self createTableView];
}

- (void)createTableView {
    _transactionDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _transactionDetailTableView.backgroundColor = WhiteColor;
    _transactionDetailTableView.delegate = self;
    _transactionDetailTableView.dataSource = self;
    _transactionDetailTableView.showsVerticalScrollIndicator = NO;
    _transactionDetailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_transactionDetailTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionDetailCell *cell = [TransactionDetailCell cellWithTableView:tableView];
    cell.titleLabel.text = @"实时收款";
    cell.timeLabel.text = @"2018/1/7 14:00:10";
    cell.amountLabel.text = @"+166元";
    cell.statusLabel.text = @"成功";
    
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
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end



























