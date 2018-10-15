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

@interface PosHomePageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *adArray;//首页广告banner数据源
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
    [self loadIndexBannerListRequest];
    NSArray *array = [PosHomePageViewController getFirstAndLastDayOfThisMonth];
    NSLog(@"array === %@", array);
    [self createTableView];
    
    [self getHeaderRequest];
}
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
    [[HPDConnect connect] PostNetRequestMethod:@"statAchievement/list" params:@{@"statType":@"0", @"userid":@"1", @"startTime":@"2017-10-10", @"endTime":@"2018-10-13",@"dateType":@"2"} cookie:nil result:^(bool success, id result) {
        NSLog(@"result ------- %@", result);
    }];
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
    headerView.volumeOfTransactionL.text = @"200000.00";
    headerView.shareProfitL.text = @"1000.00";
    headerView.activationL.text = @"20";
    headerView.teamPersonL.text = @"10";
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

    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView];
    cell.bgImg.image = [UIImage imageNamed:@"图层7"];
    cell.label.text = @"移动post机固定刷卡机百富S58（S58G）移动机专用充电器电源电源指示灯";
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


+(NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit |NSDayCalendarUnit fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
    
}
@end
