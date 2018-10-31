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
#import "POS_RootViewModel.h"
@interface POSRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;
// 加入购物车动画商品logo
@property (nonatomic, strong) UIImageView *addCartGoodLogo;
//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation POSRootViewController
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CF6F6F6;
    [self getData];
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
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POSRootCell *cell = [POSRootCell cellWithTableView:tableView];
    POS_RootViewModel *posRootM = self.dataArr[indexPath.row];
    cell.posRootModel = posRootM;
    MJWeakSelf;
    cell.addShopCarHandler = ^(UIButton * _Nonnull sender) {
        [weakSelf addShopCarWith:posRootM withBtn:sender];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(112);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    POS_RootViewModel *posRootM = self.dataArr[indexPath.row];
    POS_ShopDetailViewController *vc = [[POS_ShopDetailViewController alloc]init];
    vc.posDetailStr = [self getPosDetailStr:posRootM];
    vc.model = posRootM;
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




#pragma mark ---- 获取数据 ----
- (void)getData
{
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/packageFree/list" params:@{@"tbproductId":IF_NULL_TO_STRING(self.podId)} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = result[@"data"][@"rows"];
                    
                    self.dataArr = [POS_RootViewModel mj_objectArrayWithKeyValuesArray:arr];
                    [self.myTable reloadData];
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


#pragma mark ---- 加入购物车接口 ----
- (void)addShopCarWith:(POS_RootViewModel *)posRootM withBtn:(UIButton *)cellBtn
{
    NSDictionary *dict = @{
                           @"userid":IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:USERID]),
                           @"pkgPrdId":IF_NULL_TO_STRING(posRootM.ID),
                           @"pkgPrdType":@"1",
                           @"count":[NSString stringWithFormat:@"%li",posRootM.goodCount+1],
                           @"operation":@"1"
                           };
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/cart/save" params:dict cookie:nil result:^(bool success, id result) {
        cellBtn.userInteractionEnabled = YES;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_SUCCESS(@"成功加入购物车");
                if (self.changeShopCarCount) {
                    self.changeShopCarCount(posRootM.goodCount+1);
                }
            } else {
                HUD_ERROR(@"加入购物车失败，请稍后重试！");
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 获取拼接详情 ----
- (NSString *)getPosDetailStr:(POS_RootViewModel *)posRootM
{
    __block NSString *tmpStr = [[NSString alloc]init];
    
    [posRootM.packageFreeItemDOList enumerateObjectsUsingBlock:^(POS_RootPackageFreeModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        POS_RootProductDOModel *productDoM = [POS_RootProductDOModel mj_objectWithKeyValues:obj.productDO];
        NSString *str = [NSString stringWithFormat:@"%@%@",productDoM.posBrandName,productDoM.posTermModel];
        
        tmpStr = [tmpStr stringByAppendingString:str];
    }];
    
    return tmpStr;
}
@end
