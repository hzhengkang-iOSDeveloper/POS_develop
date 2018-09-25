//
//  PD_BillListViewController.m
//  POS_develop
//
//  Created by 孙亚男 on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListViewController.h"
#import "PD_BillListSkuCell.h"
#import "PD_BillSkuHeaderView.h"
#import "PD_BillSkuFooterView.h"
#import "PD_BillDetailViewController.h"

@interface PD_BillListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
/**
 * 订单模型数组
 */
@property (nonatomic, strong) NSMutableArray *orderModelArr;

@property (nonatomic, weak) UITableView *orderTableView;
@end

@implementation PD_BillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"我的订单";
    [self creatTableView];
    [self creatSelectBillStatus];
}
#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, AD_HEIGHT(40), ScreenWidth, ScreenHeight-AD_HEIGHT(40)-AD_HEIGHT(30)) style:UITableViewStyleGrouped];
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
}
#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"全部", @"待付款", @"待收货", @"待确认", @"已完成", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(40));
    segmentedControl.selectedSegmentIndex = 0;
    //    segmentedControl.tintColor = ORANGE_COLOR;
    //    segmentedControl.momentary = NO;
    segmentedControl.tintColor = [UIColor whiteColor];
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
                                             NSForegroundColorAttributeName: C1E95F9};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
                                               NSForegroundColorAttributeName: C000000};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl = segmentedControl;
    [self.view addSubview:segmentedControl];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"背景line"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
//    NSInteger Index = Seg.selectedSegmentIndex;
    //    NSLog(@"Index %ld", (long)Index);
//
//    self.orderArr = nil;
//    self.orderArr = [NSMutableArray array];
//    self.orderModelArr = nil;
//    self.orderModelArr = [NSMutableArray array];
//    self.loadDataIndex = 1;
//
//    switch (Index) {
//        case 0:
//            self.status = @"0";
//            [self loadDataWithStatus:@"0"];
//            break;
//        case 1:
//            self.status = @"1";
//            [self loadDataWithStatus:@"1"];
//            break;
//        case 2:
//            self.status = @"3";
//            [self loadDataWithStatus:@"3"];
//            break;
//        case 3:
//            self.status = @"4";
//            [self loadDataWithStatus:@"4"];
//            break;
//        case 4:
//            self.status = @"6";
//            [self loadDataWithStatus:@"6"];
//            break;
//
//        default:
//            break;
//    }
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
