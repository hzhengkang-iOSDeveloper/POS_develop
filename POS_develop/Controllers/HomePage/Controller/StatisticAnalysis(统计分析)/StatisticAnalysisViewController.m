//
//  StatisticAnalysisViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/8.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "StatisticAnalysisViewController.h"

@interface StatisticAnalysisViewController ()<XJYChartDelegate>
@property (nonatomic, weak) UILabel *profitCount;

//开始时间
@property (nonatomic, copy) NSString *startTime;
//结束时间
@property (nonatomic, copy) NSString *endTime;
@end

@implementation StatisticAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"统计分析";
    //获取当前时间
    self.endTime = [NSString CustomerTimeWithTimeIntervalString:[NSString nowTime] withFormatter:@"yyyy-MM-dd"];

    [self creatMainView];
}

#pragma mark ---- 计算时间 ----
- (void)calauteTimeWithType:(NSUInteger)type
{
    //获取当前时间戳
    NSUInteger currentTimeCount = [[NSString nowTime]integerValue];
    if (type == 0) {
        //日  距离当前时间30日
        NSUInteger aMonthTimeCount = 30*24*60*60;//转换为时间戳
        
        //将时间戳转换为时间
        self.startTime = [NSString CustomerTimeWithTimeIntervalString:[NSString stringWithFormat:@"%li",currentTimeCount-aMonthTimeCount] withFormatter:@"yyyy-MM-dd"];
    } else if (type == 1) {
        //周 距离当前时间半年  默认一个月30天
        NSUInteger sixMonthTimeCount = 6*30*24*60*60;//转换时间戳
        //将时间戳转换为时间
        self.startTime = [NSString CustomerTimeWithTimeIntervalString:[NSString stringWithFormat:@"%li",currentTimeCount-sixMonthTimeCount] withFormatter:@"yyyy-MM-dd"];
    } else if (type == 2) {
        //年 距离当前时间12个月  默认一个月30天
        NSUInteger yearDayCount =[self getNumberOfDaysOneYear:[NSDate dateWithTimeIntervalSinceNow:0]];
        NSUInteger yearTimeCount = yearDayCount*24*60*60;//转换时间戳
        //将时间戳转换为时间
        self.startTime = [NSString CustomerTimeWithTimeIntervalString:[NSString stringWithFormat:@"%li",currentTimeCount-yearTimeCount] withFormatter:@"yyyy-MM-dd"];
    }
}

// 获取某个日期所在年份的天数
- (NSUInteger)getNumberOfDaysOneYear:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitYear
                                  forDate: date];
    return range.length;
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
    self.profitCount = profitCount;
    
    
    //创建统计图
    [self creatChart];
    
    MJWeakSelf;
    UIView *bottomView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideTop).offset(0);
    }];
    
    for (int i = 0; i<4; i++) {
        [UIButton getButtonWithImageName:@"" titleText:i==0?@"交易量":(i==1?@"分润":(i==2?@"商户数量":@"激活数量")) superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
            make.left.offset((ScreenWidth-4*AD_HEIGHT(70))/5+(AD_HEIGHT(70)+(ScreenWidth-4*AD_HEIGHT(70))/5)*i);
            make.centerY.offset(0);
            make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(30)));
            
            btn.tag = 1000+i;
            btn.titleLabel.font  = F13;
            [btn setTitleColor:C000000 forState:normal];
            [btn setTitleColor:WhiteColor forState:UIControlStateSelected];
            [btn setBackgroundColor:CF6F6F6];
            [btn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
}
#pragma mark ---- 创建统计图 ----
- (void)creatChart
{
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
    [[XBarChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.profitCount.frame)+AD_HEIGHT(50), AD_HEIGHT(351), AD_HEIGHT(210))
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
#pragma mark ---- 底部  交易量  分润  商户数量 激活数量----
- (void)clickBottomBtn:(UIButton *)sender
{
    NSUInteger btnTag = sender.tag-1000;
    
    UIButton *profitBtn = (UIButton *)[self.view viewWithTag:1000];
    UIButton *separateQueryBtn = (UIButton *)[self.view viewWithTag:1001];
    UIButton *bussinessCountBtn = (UIButton *)[self.view viewWithTag:1002];
    UIButton *activeCountBtn = (UIButton *)[self.view viewWithTag:1003];
    
    if (btnTag == 0) {
        //交易量
        [self changeBtn:profitBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:separateQueryBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:bussinessCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:activeCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
    } else if (btnTag == 1) {
        //分润
        [self changeBtn:separateQueryBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:bussinessCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:activeCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
    } else if (btnTag == 2) {
        //商户数量
        [self changeBtn:bussinessCountBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:separateQueryBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:activeCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
    }else {
        //激活数量
        [self changeBtn:activeCountBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:separateQueryBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:bussinessCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
    }
}

- (void)changeBtn:(UIButton *)sender withSelectedStatus:(BOOL)selectS withBgColor:(UIColor *)bgColor
{
    sender.selected = selectS;
    [sender setBackgroundColor:bgColor];
}
@end
