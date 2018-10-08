//
//  StatisticAnalysisViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/8.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "StatisticAnalysisViewController.h"

@interface StatisticAnalysisViewController ()<XJYChartDelegate>

@end

@implementation StatisticAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"统计分析";
    [self creatMainView];
}

#pragma mark ---- 创建UI ----
- (void)creatMainView
{
    self.view.backgroundColor = WhiteColor;
    
    //创建顶部 日 周 月
    for (int i =0; i<3; i++) {
        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake((ScreenWidth-3*AD_HEIGHT(20))/4+((ScreenWidth-3*AD_HEIGHT(20))/4+AD_HEIGHT(20))*i, AD_HEIGHT(10), AD_HEIGHT(20), AD_HEIGHT(20));
        [topBtn setTitle:i==0?@"日":(i==1?@"周":@"月") forState:normal];
        [topBtn setTitleColor:C000000 forState:normal];
        [topBtn setTitleColor:C1E95F9 forState:UIControlStateSelected];
        topBtn.tag = 100 +i;
        [topBtn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topBtn];
    }
    
    
    //label
    UILabel *profitLabel = [[UILabel alloc]initWithFrame:CGRectMake(AD_HEIGHT(15), AD_HEIGHT(80), AD_HEIGHT(200), AD_HEIGHT(15))];
    profitLabel.adjustsFontSizeToFitWidth = YES;
    profitLabel.text = @"明日/下周/下月预期";
    profitLabel.textAlignment = NSTextAlignmentLeft;
    profitLabel.font = F13;
    profitLabel.textColor = C989898;
    [self.view addSubview:profitLabel];
    

    UILabel *profitCount = [[UILabel alloc]initWithFrame:CGRectMake(AD_HEIGHT(15), CGRectGetMaxY(profitLabel.frame)+AD_HEIGHT(10), AD_HEIGHT(200), AD_HEIGHT(15))];
    profitCount.adjustsFontSizeToFitWidth = YES;
    profitCount.text = @"￥30000元";
    profitCount.textAlignment = NSTextAlignmentLeft;
    profitCount.font = FB15;
    profitCount.textColor = C000000;
    [self.view addSubview:profitCount];
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    
    UIColor* waveColor = RGB(188, 231, 200);
    
    XBarItem* item1 = [[XBarItem alloc] initWithDataNumber:@(20.5)
                                                     color:waveColor
                                              dataDescribe:@"3月"];
    [itemArray addObject:item1];
    XBarItem* item2 = [[XBarItem alloc] initWithDataNumber:@(18.7)
                                                     color:waveColor
                                              dataDescribe:@"4月"];
    [itemArray addObject:item2];
    XBarItem* item3 = [[XBarItem alloc] initWithDataNumber:@(13.2)
                                                     color:waveColor
                                              dataDescribe:@"5月"];
    [itemArray addObject:item3];
    XBarItem* item4 = [[XBarItem alloc] initWithDataNumber:@(8.8)
                                                     color:waveColor
                                              dataDescribe:@"6月"];
    [itemArray addObject:item4];
    XBarItem* item5 = [[XBarItem alloc] initWithDataNumber:@(11.4)
                                                     color:waveColor
                                              dataDescribe:@"7月"];
    [itemArray addObject:item5];
    
    XBarItem* item6 = [[XBarItem alloc] initWithDataNumber:@(3.0)
                                                     color:waveColor
                                              dataDescribe:@"8月"];
    [itemArray addObject:item6];
    
    XBarChartConfiguration *configuration = [XBarChartConfiguration new];
    configuration.isScrollable = YES;
    configuration.x_width = 20;
    XBarChart* barChart =
    [[XBarChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(profitCount.frame)+AD_HEIGHT(50), AD_HEIGHT(351), AD_HEIGHT(210))
                       dataItemArray:itemArray
                           topNumber:@21
                        bottomNumber:@(0)
                  chartConfiguration:configuration];
    barChart.barChartDelegate = self;
    [self.view addSubview:barChart];
}

#pragma mark ---- 日  周  月 ----
- (void)clickTopBtn:(UIButton *)sender
{
    
    NSUInteger btnTag = sender.tag-100;
    
    UIButton *dayBtn = (UIButton *)[self.view viewWithTag:100];
    UIButton *weekBtn = (UIButton *)[self.view viewWithTag:101];
    UIButton *monthBtn = (UIButton *)[self.view viewWithTag:102];
    
    if (btnTag == 0) {
        //日
        dayBtn.selected = YES;
        weekBtn.selected = !dayBtn.selected;
        monthBtn.selected = !dayBtn.selected;
    } else if (btnTag == 1) {
        //周
        weekBtn.selected = YES;
        dayBtn.selected = !weekBtn.selected;
        monthBtn.selected = !weekBtn.selected;
    } else {
        //月
        monthBtn.selected = YES;
        weekBtn.selected = !monthBtn.selected;
        dayBtn.selected = !monthBtn.selected;
    }
}
@end
