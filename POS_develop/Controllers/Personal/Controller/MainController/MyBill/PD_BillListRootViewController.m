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
#import "BillListModel.h"

@interface PD_BillListRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *orderTableView;
@property (nonatomic, strong) NSMutableArray *orderArray;
@property (nonatomic, assign) int page;//接口数据当前页数
@end

@implementation PD_BillListRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderArray = [NSMutableArray array];
    self.page = 0;
    [self creatTableView];
    [self loadOrderListRequestWithIndex:self.index];
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
    
    MJWeakSelf;
    orderTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf loadOrderListRequestWithIndex:self.index];
    }];
    
    orderTableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf loadOrderListRequestWithIndex:self.index];
    }];
    [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BillListModel *model = self.orderArray[section];
    return model.detailDOList.count;
    //    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillListSkuCell *cell = [PD_BillListSkuCell cellWithTableView:tableView];
    BillListModel *model = self.orderArray[indexPath.section];
    DetailDOModel *detailModel = model.detailDOList[indexPath.row];
    cell.orderModel = detailModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(94);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BillListModel *model = self.orderArray[indexPath.section];
    
    PD_BillDetailViewController *detailVc = [[PD_BillDetailViewController alloc]init];
    detailVc.myID = model.ID;
    detailVc.orderStatu = model.orderStatus;
    detailVc.updateDataHandler = ^{
        [self loadOrderListRequestWithIndex:self.index];
    };
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PD_BillSkuHeaderView *headerView = [[PD_BillSkuHeaderView alloc] init];
    BillListModel *model = self.orderArray[section];
    headerView.model = model;
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
    BillListModel *model = self.orderArray[section];
    footerView.model = model;
    footerView.rightHandler = ^(NSString * _Nonnull orderStatus) {
        if ([orderStatus isEqualToString:@"10"]) {
            PD_BillDetailViewController *detailVc = [[PD_BillDetailViewController alloc]init];
            detailVc.myID = model.ID;
            detailVc.orderStatu = model.orderStatus;
            detailVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVc animated:YES];
        } else {
            [self comfirAddressWith:model];
        }
    };
    NSString *priceStr = [NSString stringWithFormat:@"共%ld件 应付总额：￥%@", model.detailDOList.count, model.orderPrice];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attriStr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 9)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:CF60303 range:NSMakeRange(9, priceStr.length-9)];
    footerView.countAndPriceLabel.attributedText = attriStr;
    
    return footerView;
}


#pragma mark ------------------------------------ 接口 ------------------------------------
- (void)loadOrderListRequestWithIndex:(NSString *)index{
    HUD_SHOW;
    NSDictionary *dict = @{@"offset":@(_page*10), @"limit":@10,@"orderStatus":index,@"userid":USER_ID_POS};

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/order/list" params:dict cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        [self.orderTableView.mj_header endRefreshing];
        [self.orderTableView.mj_footer endRefreshing];
        if (success) {
             if ([result[@"code"]integerValue] == 0) {
                 if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                     if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                         if (self.page == 0) {
                             [self.orderArray removeAllObjects];
                         }
                         NSArray *array = result[@"data"][@"rows"];
                        [self.orderArray addObjectsFromArray:[BillListModel mj_objectArrayWithKeyValuesArray:array]];
                         
                         if (array.count < 10) {
                             [self.orderTableView.mj_footer endRefreshingWithNoMoreData];
                         }
                         
                         [self.orderTableView reloadData];
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

#pragma mark ---- 确认收货 ----
- (void)comfirAddressWith:(BillListModel *)billModel
{
    HUD_SHOW;
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/order/update" params:@{@"id":billModel.ID,@"orderStatus":@"40"} cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_SUCCESS(@"操作成功！");
                [self loadOrderListRequestWithIndex:self.index];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
































