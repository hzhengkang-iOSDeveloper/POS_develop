//
//  PosHomePageViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PosHomePageViewController.h"
#import "HomeTableViewCell.h"
#import "PosHomePageHeaderView.h"
#import "AchievementsViewController.h"
#import "MessageNoticeViewController.h"
#import "IndexBannerListModel.h"
#import "HomeHeaderModel.h"
#import "PackageChargeListModel.h"

@interface PosHomePageViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSString *startTime;
    NSString *endTime;
}
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *adArray;//首页广告banner数据源
@property (nonatomic, strong) NSMutableArray *dataArray;//套餐数据源
@property (nonatomic, weak) PosHomePageHeaderView *headerView;
@end

@implementation PosHomePageViewController
- (NSMutableArray *)adArray
{
    if (!_adArray) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"支付管理";
    MJWeakSelf;
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"消息"] clickHandler:^{
        MessageNoticeViewController *vc = [[MessageNoticeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self addBackButtonWithImage:[UIImage imageNamed:@"图层3拷贝-1"]  clickHandler:^{

    }];
  
    
    [self createTableView];
    
    [self loadIndexBannerListRequest];
    [self loadPackageChargeListRequest];
    [self getHeaderRequest];
}

- (void)createTableView {
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight - navH) style:UITableViewStylePlain];
    _homeTableView.backgroundColor = CF6F6F6;
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.tableHeaderView = [self createHeaderView];
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_homeTableView];
}


- (UIView *)createHeaderView {
    PosHomePageHeaderView *headerView = [[PosHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(140)+AD_HEIGHT(32)+AD_HEIGHT(82)+AD_HEIGHT(25)+AD_HEIGHT(165)+AD_HEIGHT(44))];
    headerView.currentMonthBlock = ^{
        AchievementsViewController *vc = [[AchievementsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.headerView = headerView;
    return headerView;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView];
    PackageChargeListModel *model = self.dataArray[indexPath.section];
    [cell.bgImg sd_setImageWithURL:[NSURL URLWithString:model.packagePic]];
    cell.label.text = model.packageName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;



    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(192);
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = CF6F6F6;
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FITiPhone6(10);
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(5))];
    view.backgroundColor = CF6F6F6;
    return view;
}


- (void)getMonthBeginAndEndWith:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString  *strStateTime = [myDateFormatter stringFromDate:beginDate];
    NSString  *strEndTime = [myDateFormatter stringFromDate:endDate];
    
    startTime = strStateTime;
    endTime = strEndTime;
    
}


#pragma mark ---- 接口 ----
- (void)loadIndexBannerListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"indexBanner/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array =result[@"data"][@"rows"];
                    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[IndexBannerListModel mj_objectArrayWithKeyValuesArray:array]];
                    [dataArr enumerateObjectsUsingBlock:^(IndexBannerListModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.adArray addObject:model.bannerPic];
                    }];
                    
                    self.headerView.adArray = [NSArray arrayWithArray:self.adArray];
                    
                }
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


- (void)getHeaderRequest {
    //当前时间
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    [self getMonthBeginAndEndWith:dateStr];
    
    //当⽉月交易易量量
    [[HPDConnect connect] PostNetRequestMethod:@"statAchievement/list" params:@{@"statType":@"0", @"userid":@"1", @"startTime":startTime, @"endTime":endTime,@"dateType":@"2"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSDictionary *array = result[@"data"][@"rows"];
                    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[HomeHeaderModel mj_objectArrayWithKeyValuesArray:array]];
                    if (array.count > 0) {
                        [dataArr enumerateObjectsUsingBlock:^(HomeHeaderModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                            self.headerView.volumeOfTransactionL.text = model.statAmount;
                        }];
                    }
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
    //当⽉月分润
    [[HPDConnect connect] PostNetRequestMethod:@"statShareBenefit/list" params:@{@"statType":@"1", @"userid":@"1", @"startTime":startTime, @"endTime":endTime,@"dateType":@"2"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSDictionary *array = result[@"data"][@"rows"];
                    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[HomeHeaderModel mj_objectArrayWithKeyValuesArray:array]];
                    if (array.count > 0) {
                        [dataArr enumerateObjectsUsingBlock:^(HomeHeaderModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                            self.headerView.shareProfitL.text = model.statAmount;
                        }];
                    }
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
    //当⽉月激活数量量
    [[HPDConnect connect] PostNetRequestMethod:@"statAchievement/list" params:@{@"statType":@"2", @"userid":@"1", @"startTime":startTime, @"endTime":endTime,@"dateType":@"2"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSDictionary *array = result[@"data"][@"rows"];
                    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[HomeHeaderModel mj_objectArrayWithKeyValuesArray:array]];
                    if (array.count > 0) {
                        [dataArr enumerateObjectsUsingBlock:^(HomeHeaderModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                            self.headerView.activationL.text = model.statAmount;
                        }];
                    }
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
//    //当前团队⼈人数
    [[HPDConnect connect] PostNetRequestMethod:@"statAchievement/list" params:@{@"statType":@"4", @"userid":@"1", @"startTime":startTime, @"endTime":endTime,@"dateType":@"2"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    
                    NSDictionary *array = result[@"data"][@"rows"];
                    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[HomeHeaderModel mj_objectArrayWithKeyValuesArray:array]];
                    if (array.count > 0) {
                        [dataArr enumerateObjectsUsingBlock:^(HomeHeaderModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                            self.headerView.teamPersonL.text = model.statAmount;
                        }];
                    }
                }
            }
           
        }
        NSLog(@"result ------- %@", result);
    }];
    
}


#pragma mark ---- 套餐接口 ----
- (void)loadPackageChargeListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"packageCharge/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    self.dataArray = [NSMutableArray arrayWithArray:[PackageChargeListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.homeTableView reloadData];
                }
                
            }
           
        }
        NSLog(@"result ------- %@", result);
    }];
    
}
@end
