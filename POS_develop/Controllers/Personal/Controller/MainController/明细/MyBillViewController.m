//
//  MyBillViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyBillViewController.h"
#import "MyBillTableViewCell.h"
#import "BagLogListModel.h"

@interface MyBillViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *billTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationItemTitle = @"明细";
    self.dataArray = [NSMutableArray array];
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"图层1"] clickHandler:^{
        NSLog(@"点击右边按钮");
    }];
    [self createTableView];
    [self loadBagLogListRequest];
}

- (void)createTableView {
    _billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _billTableView.backgroundColor = WhiteColor;
    _billTableView.delegate = self;
    _billTableView.dataSource = self;
    _billTableView.showsVerticalScrollIndicator = NO;
    _billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJWeakSelf;
    _billTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadBagLogListRequest];
    }];
    [self.view addSubview:_billTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyBillTableViewCell *cell = [MyBillTableViewCell cellWithTableView:tableView];
    BagLogListModel *model = self.dataArray[indexPath.row];
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

- (void)loadBagLogListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagLog/list" params:nil cookie:nil result:^(bool success, id result) {
        [self.billTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    self.dataArray = [NSMutableArray arrayWithArray:[BagLogListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.billTableView reloadData];
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end






















