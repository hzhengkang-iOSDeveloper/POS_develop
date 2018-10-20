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
#import "SeparateQueryRootViewController.h"


@interface SeparateQueryDetailViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, weak) SeparateQueryDetailHeaderView *headerView;
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl

@end

@implementation SeparateQueryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分润详情（个人）";
    self.view.backgroundColor = CF6F6F6;
    
    [self creatSelectBillStatus];
    [self initUI];
}

- (void)initUI {
    SeparateQueryDetailHeaderView *headerView = [[SeparateQueryDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(194))];
    headerView.totalLael.text = @"7000.00";
    headerView.totalPenLabel.text = @"18000";
    headerView.totalAmountLabel.text = @"7000188";
    headerView.searchBlock = ^{
        SeparateQuerySearchViewController *vc = [[SeparateQuerySearchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.pageController.view addSubview:headerView];
    self.headerView = headerView;
}


#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{

    _pageController = [[WMPageController alloc]init];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.menuItemWidth = ScreenWidth/4;
    _pageController.titleColorNormal = C000000;
    _pageController.titleColorSelected = C1E95F9;
    _pageController.titleSizeNormal = 13;
    _pageController.titleSizeSelected = 13;
    _pageController.menuViewStyle = WMMenuViewStyleLine;
    _pageController.progressWidth = AD_HEIGHT(51);
    [_pageController reloadData];
}

#pragma mark ---- WMPageControllerDelegate,WMPageControllerDataSource ----
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 4;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SeparateQueryRootViewController* vc = [[SeparateQueryRootViewController alloc]init];
    vc.startTime = self.startTime;
    vc.endTime = self.endTime;
    vc.agentName = self.agentName;
    vc.agentNo = self.agentNo;
    vc.agentType = self.agentType;
    
    
    [vc loadShareBenefitListRequest:[NSString stringWithFormat:@"%li",(long)index]];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"综合排序";
        case 1:
            return @"总金额";
        case 2:
            return @"总分润";
        case 3:
            return @"总笔数";
    }
    return @"";
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    return CGRectMake(0, originY, ScreenWidth,ScreenHeight- (CGRectGetMaxY(self.headerView.frame)+AD_HEIGHT(5)+AD_HEIGHT(39))-navH);
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+AD_HEIGHT(5), ScreenWidth, AD_HEIGHT(38));
}



@end
















