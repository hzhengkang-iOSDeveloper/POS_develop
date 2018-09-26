//
//  PD_BillListViewController.m
//  POS_develop
//
//  Created by 孙亚男 on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListViewController.h"
#import "PD_BillListRootViewController.h"
@interface PD_BillListViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
/**
 * 订单模型数组
 */
@property (nonatomic, strong) NSMutableArray *orderModelArr;
@end

@implementation PD_BillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"我的订单";
//    [self creatTableView];
    [self creatSelectBillStatus];
}

#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{
//    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"全部", @"待付款", @"待收货", @"待确认", @"已完成", nil];
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
//    segmentedControl.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(40));
//    segmentedControl.selectedSegmentIndex = 0;
//    //    segmentedControl.tintColor = ORANGE_COLOR;
//    //    segmentedControl.momentary = NO;
//    segmentedControl.tintColor = [UIColor whiteColor];
//
//    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
//                                             NSForegroundColorAttributeName: C1E95F9};
//    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
//    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
//                                               NSForegroundColorAttributeName: C000000};
//    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
//
//    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
//    self.segmentedControl = segmentedControl;
//    [self.view addSubview:segmentedControl];
//    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"背景line"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    _pageController = [[WMPageController alloc]init];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.menuItemWidth = ScreenWidth/5;
    _pageController.titleColorNormal = C000000;
    _pageController.titleColorSelected = C1E95F9;
    _pageController.titleSizeNormal = 13;
    _pageController.titleSizeSelected = 13;
    _pageController.menuViewStyle = WMMenuViewStyleLine;
    _pageController.progressWidth = AD_HEIGHT(47);
    [_pageController reloadData];
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

#pragma mark ---- WMPageControllerDelegate,WMPageControllerDataSource ----
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 5;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    PD_BillListRootViewController* controller = [[PD_BillListRootViewController alloc]init];
    //    switch (index) {
    //        case 0:{
    //            controller.fileType = ARMFileTypeAll;
    //        }
    //            break;
    //        case 1:{
    //            controller.fileType = ARMFileTypeAudio;
    //        }
    //            break;
    //        case 2:{
    //            controller.fileType = ARMFileTypeTxt;
    //        }
    //            break;
    //        default:
    //            break;
    //    }
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"全部";
        case 1:
            return @"待付款";
        case 2:
            return @"待收货";
        case 3:
            return @"待确认";
        case 4:
            return @"已完成";
    }
    return @"";
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    return CGRectMake(0, originY+AD_HEIGHT(5), ScreenWidth,ScreenHeight- (originY+AD_HEIGHT(5)+navH));
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(40));
}
@end
