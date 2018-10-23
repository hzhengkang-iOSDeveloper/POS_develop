//
//  ActivationMoneyDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ActivationMoneyDetailViewController.h"
#import "ActivationMoneyDetailHeaderView.h"
#import "ActivationMoneyRootViewController.h"
#import "ActivationMoneySearchViewController.h"

@interface ActivationMoneyDetailViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl
@property (nonatomic, weak) ActivationMoneyDetailHeaderView *headerView;
@end

@implementation ActivationMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.agentType isEqualToString:@"1"]) {
        self.navigationItem.title = @"激活返现详情（代理商）";
    }else {
        self.navigationItem.title = @"激活返现详情（个人）";
    }
    
    
    [self creatSelectBillStatus];
    [self initUI];

}

- (void)initUI {
    ActivationMoneyDetailHeaderView *headerView = [[ActivationMoneyDetailHeaderView alloc] init];
    headerView.totalPenLabel.text = @"18000.01";
    headerView.totalAmountLabel.text = @"70";
    headerView.searchBlock = ^{
        ActivationMoneySearchViewController *vc = [[ActivationMoneySearchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.pageController.view addSubview:headerView];
    self.headerView = headerView;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(167)));
    }];
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
    return 3;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    ActivationMoneyRootViewController* controller = [[ActivationMoneyRootViewController alloc]init];
    controller.startTime = self.startTime;
    controller.endTime = self.endTime;
    controller.agentType = self.agentType;
    
    [controller loadActivationRebateListRequest:[NSString stringWithFormat:@"%li",(long)index]];
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"综合排序";
        case 1:
            return @"总金额";
        case 2:
            return @"激活台数";
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
