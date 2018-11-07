//
//  MyFreeGetRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "MyFreeGetRootViewController.h"
#import "MyFreeGetCell.h"
#import "POS_RootViewModel.h"
#import "PD_BillDetailViewController.h"
@interface MyFreeGetRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;

//最大领取view
@property (nonatomic, weak) UIButton *maxGetBtn;
//确认领取View
@property (nonatomic, weak) UIButton *comfirBtn;
//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *maxGoodCount;//最大领取数量
@end

@implementation MyFreeGetRootViewController

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
    [self creatBottomView];
    [self getData];
    [self getGoodMaxCountRequest];
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
        [weakSelf getData];
    }];
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(5));
        make.left.offset(0);
        make.bottom.equalTo(self.comfirBtn.mas_top);
        make.width.mas_equalTo(ScreenWidth);
    }];
}

#pragma mark ---- bottomView ----
- (void)creatBottomView
{
    UIButton *maxGetBtn = [UIButton getButtonWithImageName:@"" titleText:@"(已达到最大领取数量)" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(-(ScreenWidth/2));
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth/2, AD_HEIGHT(49)));
        
        btn.titleLabel.font = F13;
        [btn setTitleColor:WhiteColor forState:normal];
        [btn setBackgroundColor:RGB(239, 0, 51)];
    }];
    self.maxGetBtn = maxGetBtn;
    MJWeakSelf;
    
    UIButton *comfirBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认领取" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(weakSelf.maxGetBtn.mas_right);
        make.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.height.mas_offset(AD_HEIGHT(49));
        
        btn.titleLabel.font = F13;
        [btn setTitleColor:WhiteColor forState:normal];
        [btn setBackgroundColor:C1E95F9];
        [btn addTarget:self action:@selector(commfirGetGood) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.comfirBtn = comfirBtn;
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyFreeGetCell *cell = [MyFreeGetCell cellWithTableView:tableView];
    __weak typeof(cell) weakCell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    POS_RootViewModel *posRootM = self.dataArr[indexPath.row];
    cell.posRootModel = posRootM;
    MJWeakSelf;
    cell.clickChangeCountHandler = ^(BOOL isAdd) {
        //遍历数据源 计算所有的数量
        
        __block NSUInteger goodAllCout = 0;
        [weakSelf.dataArr enumerateObjectsUsingBlock:^(POS_RootViewModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            goodAllCout = goodAllCout +obj.goodCount;
        }];
        
        if (goodAllCout >= [self.maxGoodCount integerValue]) {
            HUD_TIP(@"超过最大领取数量");
            [UIView animateWithDuration:2 animations:^{
                [weakSelf.maxGetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                }];
            }];

        } else {
            [UIView animateWithDuration:2 animations:^{
                [weakSelf.maxGetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(-(ScreenWidth/2));
                }];
            }];

            if (isAdd) {
                [weakCell changeGoodCount];
                [weakSelf.comfirBtn setTitle:[NSString stringWithFormat:@"确认领取（%li）",goodAllCout+1] forState:normal];
            } else {
                if (goodAllCout == 0) {
                    [weakSelf.comfirBtn setTitle:@"确认领取" forState:normal];
                } else {
                    [weakSelf.comfirBtn setTitle:[NSString stringWithFormat:@"确认领取（%li）",goodAllCout] forState:normal];
                }
            }
        }
        
        
        
    };
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(112);
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
#pragma mark ---- 获取数据 ----
- (void)getData
{
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/packageFree/list" params:@{@"tbProductId":IF_NULL_TO_STRING(self.podId)} cookie:nil result:^(bool success, id result) {
        [self.myTable.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = result[@"data"][@"rows"];
                        
                        self.dataArr = [POS_RootViewModel mj_objectArrayWithKeyValuesArray:arr];
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

#pragma mark ---- 最大领取数量 ----
- (void)getGoodMaxCountRequest
{
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/creditRule/list" params:@{@"userid":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [NSArray arrayWithArray:result[@"data"][@"rows"]];
                    self.maxGoodCount = defaultObject(IF_NULL_TO_STRING([arr.firstObject objectForKey:@"leftCount"]), @"0");
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 确认领取 ----
- (void)commfirGetGood
{
    
    //遍历数据源 拿到所有选择数量的item
    __block NSString *pkgPrdIds = [NSString string];
    __block NSString *pkgPrdTypes= [NSString string];
    __block NSString *counts= [NSString string];
    [self.dataArr enumerateObjectsUsingBlock:^(POS_RootViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.goodCount >0) {
            pkgPrdIds = [pkgPrdIds stringByAppendingString:obj.ID];
            pkgPrdTypes = [pkgPrdTypes stringByAppendingString:@"2"];
            counts = [counts stringByAppendingString:[NSString stringWithFormat:@"%lu",obj.goodCount+1]];
        }
    }];
    
    if ([pkgPrdIds isEqualToString:@""]) {
        HUD_TIP(@"请选择领取套餐数量!");
        return;
    }
    
    NSDictionary *dict = @{
                           @"userid":USER_ID_POS,
                           @"pkgPrdIds":IF_NULL_TO_STRING(pkgPrdIds),
                           @"pkgPrdTypes":IF_NULL_TO_STRING(pkgPrdTypes),
                           @"counts":IF_NULL_TO_STRING(counts),
                           @"operation":@"0"
                           };
    HUD_NOBGSHOW;
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/order/save" params:dict cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                PD_BillDetailViewController *vc = [[PD_BillDetailViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.myID = [NSString stringWithFormat:@"%@",result[@"data"]];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
