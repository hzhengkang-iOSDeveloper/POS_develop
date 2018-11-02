//
//  ActivationMoneyRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ActivationMoneyRootViewController.h"
#import "ActivationMoneyCell.h"
#import "ActivationRebateListModel.h"

@interface ActivationMoneyRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;
@property (nonatomic, copy) NSString *index;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ActivationMoneyRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self creatTableView];
}

#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    self.myTable = myTable;
    myTable.separatorStyle = NO;
    
    MJWeakSelf;
    myTable.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadActivationRebateListRequest:weakSelf.index];
    }];
    
    
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivationMoneyCell *cell = [ActivationMoneyCell cellWithTableView:tableView];
    cell.dateLabel.text = [NSString stringWithFormat:@"交易日期%@——%@", self.startTime, self.endTime];
    ActivationRebateListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(91);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- 激活返现查询 ----
- (void)loadActivationRebateListRequest:(NSString *)orderBy {

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/activationRebate/list" params:@{@"userid":USER_ID_POS,@"startTime":defaultObject(self.startTime, @""), @"endTime":defaultObject(self.endTime, @""), @"agentType":self.agentType, @"orderBy":orderBy} cookie:nil result:^(bool success, id result) {
        [self.myTable.mj_header endRefreshing];
        self.index = orderBy;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"objectList"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = result[@"data"][@"objectList"];
                        if (self.dataArray.count >0) {
                            [self.dataArray removeAllObjects];
                        }
                        [self.dataArray addObjectsFromArray:[ActivationRebateListModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.myTable reloadData];
                    }
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
















