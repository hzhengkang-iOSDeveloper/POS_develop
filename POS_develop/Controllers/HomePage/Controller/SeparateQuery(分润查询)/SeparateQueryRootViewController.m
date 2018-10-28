//
//  SeparateQueryRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/26.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SeparateQueryRootViewController.h"
#import "SeparateQueryCell.h"
#import "ShareBenefitListModel.h"
@interface SeparateQueryRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *index;
@end

@implementation SeparateQueryRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.dataArray = [NSMutableArray array];
    self.index = @"0";
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
        [weakSelf loadShareBenefitListRequest:weakSelf.index];
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
    
    SeparateQueryCell *cell = [SeparateQueryCell cellWithTableView:tableView];
    cell.time.text = [NSString stringWithFormat:@"交易日期%@——%@", self.startTime,self.endTime];
    ShareBenefitListModel *model = self.dataArray[indexPath.row];
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

#pragma mark ---- 分润查询 ----
- (void)loadShareBenefitListRequest:(NSString *)orderBy {
    
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/shareBenefit/list" params:@{@"userid":@"1",@"startTime":defaultObject(self.startTime, @""), @"endTime":defaultObject(self.endTime, @""), @"agentName":defaultObject(self.agentName, @""), @"agentNo":defaultObject(self.agentNo, @""), @"agentType":self.agentType, @"orderBy":orderBy} cookie:nil result:^(bool success, id result) {
        [self.myTable.mj_header endRefreshing];
        self.index = orderBy;
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"objectList"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"objectList"];
                    if (self.dataArray.count >0) {
                        [self.dataArray removeAllObjects];
                    }
                    [self.dataArray addObjectsFromArray:[ShareBenefitListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTable reloadData];
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end

























