//
//  POSRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POSRootViewController.h"
#import "POSRootCell.h"
#import "POS_ShopDetailViewController.h"
#import "POS_CommitBillViewController.h"
@interface POSRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;
// 加入购物车动画商品logo
@property (nonatomic, strong) UIImageView *addCartGoodLogo;
@end

@implementation POSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CF6F6F6;
    [self creatTableView];
}
#pragma mark - 加入购物车动画logo
- (UIImageView *)addCartGoodLogo {
    if (!_addCartGoodLogo) {
        UIImageView *addCartGoodLogo = [UIImageView new];
        addCartGoodLogo.image = ImageNamed(@"购物车");
        _addCartGoodLogo = addCartGoodLogo;
        [self.view addSubview:addCartGoodLogo];
    }
    return _addCartGoodLogo;
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
        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2];
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
        make.top.offset(AD_HEIGHT(5));
        make.left.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}

#pragma mark ---- 停止刷新 ----
- (void)endRefresh
{
//    [self.myTable.mj_footer endRefreshing];
//    [self.myTable.mj_header endRefreshing];
    [self.myTable.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POSRootCell *cell = [POSRootCell cellWithTableView:tableView];
    MJWeakSelf;
    cell.addShopCarHandler = ^{
        if (weakSelf.changeShopCarCount) {
            weakSelf.changeShopCarCount();
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(112);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POS_ShopDetailViewController *vc = [[POS_ShopDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
