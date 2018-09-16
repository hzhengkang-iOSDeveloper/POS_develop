//
//  PD_BillListViewController.m
//  POS_develop
//
//  Created by 孙亚男 on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListViewController.h"

@interface PD_BillListViewController ()
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
@end

@implementation PD_BillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    [self creatSelectBillStatus];
}

#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"全部订单", @"待付款", @"待收货", @"交易完成", @"交易取消", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(40));
    segmentedControl.selectedSegmentIndex = 0;
    //    segmentedControl.tintColor = ORANGE_COLOR;
    //    segmentedControl.momentary = NO;
    segmentedControl.tintColor = [UIColor whiteColor];
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
                                             NSForegroundColorAttributeName: C1E95F9};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
                                               NSForegroundColorAttributeName: C090909};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl = segmentedControl;
    [self.view addSubview:segmentedControl];
//    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segSelectedBackgroundImg"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"segbg"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
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
@end
