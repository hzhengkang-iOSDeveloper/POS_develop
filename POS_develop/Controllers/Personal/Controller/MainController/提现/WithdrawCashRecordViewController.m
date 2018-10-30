//
//  WithdrawCashRecordViewController.m
//  POS_develop
//
//  Created by syn on 2018/10/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "WithdrawCashRecordViewController.h"
#import "BagWithdrawCell.h"
#import "BagWithdrawListModel.h"

@interface WithdrawCashRecordViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WithdrawCashRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"提现记录";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadBagWithdrawListRequest];
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJWeakSelf;
    _myTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadBagWithdrawListRequest];
    }];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.offset(0);
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BagWithdrawCell *cell = [BagWithdrawCell cellWithTableView:tableView];
    BagWithdrawListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(65);
}


#pragma mark -------------------------------- 接口 ------------------------------------

- (void)loadBagWithdrawListRequest {
    LoginManager *manager = [LoginManager getInstance];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagWithdraw/list" params:@{@"userid":IF_NULL_TO_STRING(manager.userInfo.userId)} cookie:nil result:^(bool success, id result) {
        [self.myTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    self.dataArray = [NSMutableArray arrayWithArray:[BagWithdrawListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTableView reloadData];
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

@end
