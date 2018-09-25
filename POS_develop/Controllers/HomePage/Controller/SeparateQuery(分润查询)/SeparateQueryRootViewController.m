//
//  SeparateQueryRootViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryRootViewController.h"
#import "SQ_ComprehensiveRanking.h"
#import "SQ_TotalAmount.h"
#import "SQ_TotalShareProfit.h"
#import "SQ_TotalPenNumber.h"

@interface SeparateQueryRootViewController () <XLBasePageControllerDelegate,XLBasePageControllerDataSource>
{
    NSArray *_nameArr;
}
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation SeparateQueryRootViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用 iOS7 滑动返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"综合排序", @"总金额", @"总分润", @"总笔数"];
    _nameArr = [NSArray array];
    
    
    self.delegate = self;
    self.dataSource = self;
    
    //self.lineWidth = 2.0;//选中下划线宽度
    self.titleFont = F13;
    self.btnTitleWidth = ScreenWidth/4;//btnTitle的宽度
    self.defaultColor = C000000;//默认字体颜色
    self.chooseColor = C1E95F9;//选中字体颜色
    self.selectIndex = 0;//默认选中第几页
    [self reloadScrollPage];
//    [self Get_Transaction_Type];//接口获取数据
}
#pragma mark 代理
-(NSInteger)numberViewControllersInViewPager:(XLBasePageController *)viewPager
{
    return _titleArray.count;
}

-(UIViewController *)viewPager:(XLBasePageController *)viewPager indexViewControllers:(NSInteger)index
{
//    TransactionRecordTitleModel *model = [self.titleArray objectAtIndex:index];
//    switch ([model.code intValue]) {
      switch (index) {
        case 0:
        {
            //综合排序
            SQ_ComprehensiveRanking *vc = [[SQ_ComprehensiveRanking alloc] init];
//            transactionRecord_rechargeVC.titleStr = model.name;
//            transactionRecord_rechargeVC.index = index;
//            transactionRecord_rechargeVC.code = model.code;
            return vc;
        }
        case 1:
        {
            //总金额
            SQ_TotalAmount *vc = [[SQ_TotalAmount alloc] init];
            return vc;
        }
        case 2:
        {
            //总分润
            SQ_TotalShareProfit *vc = [[SQ_TotalShareProfit alloc] init];
            return vc;
        }
        case 3:
        {
            //总笔数
            SQ_TotalPenNumber *vc = [[SQ_TotalPenNumber alloc] init];
            return vc;
        }
       
        default:
            break;
    }
    
    return nil;
}

-(CGFloat)heightForTitleViewPager:(XLBasePageController *)viewPager
{
    return FITiPhone6(36);
}

-(NSString *)viewPager:(XLBasePageController *)viewPager titleWithIndexViewControllers:(NSInteger)index
{
//    TransactionRecordTitleModel *model = [self.titleArray objectAtIndex:index];
    return [self.titleArray objectAtIndex:index];;
}

-(void)viewPagerViewController:(XLBasePageController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
}

#pragma mark  顶部视图
-(UIView *)headerViewForInViewPager:(XLBasePageController *)viewPage
{
    return [UIView new];
};
-(CGFloat)heightForHeaderViewPager:(XLBasePageController *)viewPager
{
    return FITiPhone6(2);
}

#pragma mark 接口获取title
-(void)Get_Transaction_Type{

//    [[HPDConnect connect] webservicesAFNetPOSTMethod:KsoapMethodGet_Transaction_Type params:nil cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
//        if (success) {
//            if ([[result valueForKey:kSoapResponseStatu] intValue] == 1){
//                //                [GlobalMethod cacheCurrentPort:KsoapMethodGet_Transaction_Type cacheDic:result];///缓存
//                TransactionRecordTitleModel *model = [[TransactionRecordTitleModel alloc]init];
//                model.name = @"全部";
//                model.code = @"";
//                //                [_titleArray addObject:model];
//
//                [_titleArray addObjectsFromArray:[TransactionRecordTitleModel mj_objectArrayWithKeyValuesArray:[GlobalMethod toArrayOrNSDictionary:[result[@"doObject"] dataUsingEncoding:NSUTF8StringEncoding]]]];
//                [self reloadScrollPage];
//            }
//        }
//    }];
}
@end
