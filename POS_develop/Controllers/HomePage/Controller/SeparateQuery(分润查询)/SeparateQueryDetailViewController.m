//
//  SeparateQueryDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryDetailViewController.h"
#import "SeparateQueryDetailHeaderView.h"
#import "SeparateQuerySearchViewController.h"
#import "SeparateQueryCell.h"
@interface SeparateQueryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SeparateQueryDetailHeaderView *headerView;
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
@property (nonatomic, weak) UITableView *myTable;
@end

@implementation SeparateQueryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分润详情（个人）";
    self.view.backgroundColor = CF6F6F6;
    [self initUI];
    [self creatSelectBillStatus];
    [self creatTableView];
}

- (void)initUI {
    SeparateQueryDetailHeaderView *headerView = [[SeparateQueryDetailHeaderView alloc] init];
    headerView.totalLael.text = @"7000.00";
    headerView.totalPenLabel.text = @"18000";
    headerView.totalAmountLabel.text = @"7000188";
    headerView.searchBlock = ^{
        SeparateQuerySearchViewController *vc = [[SeparateQuerySearchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(194)));
    }];
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
        make.left.offset(0);
        make.top.equalTo(weakSelf.segmentedControl.mas_bottom).offset(1);
        make.bottom.offset(0);
        make.width.mas_equalTo(ScreenWidth);
//        make.size.mas_offset(CGSizeMake(ScreenWidth, ScreenHeight-AD_HEIGHT(240)));
    }];
}

#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{
    MJWeakSelf;
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"综合排序", @"总金额", @"总分润", @"总笔数", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(36));
    segmentedControl.selectedSegmentIndex = 0;
    //    segmentedControl.tintColor = ORANGE_COLOR;
    //    segmentedControl.momentary = NO;
    segmentedControl.tintColor = [UIColor whiteColor];
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:F13,
                                             NSForegroundColorAttributeName: C1E95F9};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:F13,
                                               NSForegroundColorAttributeName: C000000};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl = segmentedControl;
    [self.view addSubview:segmentedControl];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"背景line"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(AD_HEIGHT(5));
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(38)));
    }];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SeparateQueryCell *cell = [SeparateQueryCell cellWithTableView:tableView];
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
