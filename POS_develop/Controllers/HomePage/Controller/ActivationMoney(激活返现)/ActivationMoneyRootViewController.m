//
//  ActivationMoneyRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ActivationMoneyRootViewController.h"
#import "ActivationMoneyCell.h"
@interface ActivationMoneyRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;

@end

@implementation ActivationMoneyRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        //        weakSelf.orderArr = nil;
        //        weakSelf.orderArr = [NSMutableArray array];
        //        weakSelf.orderModelArr = nil;
        //        weakSelf.orderModelArr = [NSMutableArray array];
        //        weakSelf.loadDataIndex = 1;
        //
        //        [weakSelf loadDataWithStatus:self.status];
    }];
    
    myTable.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
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
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivationMoneyCell *cell = [ActivationMoneyCell cellWithTableView:tableView];
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

@end
