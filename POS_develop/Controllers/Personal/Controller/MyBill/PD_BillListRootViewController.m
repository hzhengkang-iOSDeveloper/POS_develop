//
//  PD_BillListRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/26.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillListRootViewController.h"
#import "PD_BillDetailViewController.h"
#import "PD_BillListSkuCell.h"
#import "PD_BillSkuHeaderView.h"
#import "PD_BillSkuFooterView.h"
@interface PD_BillListRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *orderTableView;
@end

@implementation PD_BillListRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView];
}

#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *orderTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
    self.orderTableView = orderTableView;
    orderTableView.separatorStyle = NO;
    
    //    MJWeakSelf;
    orderTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        //        weakSelf.orderArr = nil;
        //        weakSelf.orderArr = [NSMutableArray array];
        //        weakSelf.orderModelArr = nil;
        //        weakSelf.orderModelArr = [NSMutableArray array];
        //        weakSelf.loadDataIndex = 1;
        //
        //        [weakSelf loadDataWithStatus:self.status];
    }];
    
    orderTableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
        //        weakSelf.loadDataIndex += 1;
        //
        //        if (weakSelf.count%10 >0) {
        //            if (weakSelf.loadDataIndex <= weakSelf.count/10 + 1) {
        //
        //                [weakSelf loadDataWithStatus:weakSelf.status];
        //            }else{
        //
        //                [orderTableView.mj_footer endRefreshingWithNoMoreData];
        //            }
        //        }else{
        //
        //            if (weakSelf.loadDataIndex <= weakSelf.count/10) {
        //
        //                [weakSelf loadDataWithStatus:weakSelf.status];
        //            }else{
        //                [orderTableView.mj_footer endRefreshingWithNoMoreData];
        //            }
        //        }
    }];
    [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    SLLog(@"%lu",(unsigned long)[[self.orderModelArr[section] items] count]);
    return 2;
    //    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillListSkuCell *cell = [PD_BillListSkuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(94);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillDetailViewController *detailVc = [[PD_BillDetailViewController alloc]init];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PD_BillSkuHeaderView *headerView = [[PD_BillSkuHeaderView alloc] init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(41);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AD_HEIGHT(68);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    PD_BillSkuFooterView *footerView = [[PD_BillSkuFooterView alloc] init];
    
    return footerView;
}
@end
