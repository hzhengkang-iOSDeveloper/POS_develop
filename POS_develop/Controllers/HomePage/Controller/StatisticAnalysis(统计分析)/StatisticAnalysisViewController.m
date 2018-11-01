//
//  StatisticAnalysisViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/8.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "StatisticAnalysisViewController.h"
#import "StatisticAnalysisModel.h"
@interface StatisticAnalysisViewController ()<XJYChartDelegate>
@property (nonatomic, weak) UILabel *profitCount;

//开始时间
@property (nonatomic, copy) NSString *startTime;
//结束时间
@property (nonatomic, copy) NSString *endTime;
//时间种类
@property (nonatomic, copy) NSString *dateType;
//底部类型
@property (nonatomic, copy) NSString *statType;
//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) XBarChart* barChart;
@end

@implementation StatisticAnalysisViewController
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
    self.navigationItemTitle = @"统计分析";

    [self creatMainView];
    
    //设置初始数据
    [self calauteTimeWithType:0];
    self.dateType = @"0";
    self.statType = @"0";
    [self getStatisticAnalysisData];
}

#pragma mark ---- 计算时间 ----
- (void)calauteTimeWithType:(NSUInteger)type
{
    //获取当前时间
    self.endTime = [NSString CustomerTimeWithTimeIntervalString:[NSString nowTime] withFormatter:@"yyyy-MM-dd"];
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
        if (i == 0) {
            topBtn.selected = YES;
        }
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
            [btn setBackgroundColor:CF6F6F6];
            [btn setTitleColor:WhiteColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i== 0) {
                btn.selected = YES;
                [btn setBackgroundColor:C00A0E9];
            }
        }];
    }
}

#pragma mark ---- str转number ----
- (NSNumber *)goNumberWithStr:(NSString *)string
{
    NSNumberFormatter *tempNum = [[NSNumberFormatter alloc] init];
    
    [tempNum setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *numTemp = [tempNum numberFromString:string];
    return numTemp;
}
#pragma mark ---- 创建统计图 ----
- (void)creatChart
{
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    
    UIColor* waveColor = RGB(188, 231, 200);
    //@"   2018.10.12"  @"2018.10.21 ~  2019.11.21"
    //判断选择情况
    if ([self.dateType isEqualToString:@"0"]) {
        //日
        [self.dataArr enumerateObjectsUsingBlock:^(StatisticAnalysisModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            XBarItem* item = [[XBarItem alloc] initWithDataNumber:[self goNumberWithStr:model.value]
                                                            color:waveColor
                                                     dataDescribe:[NSString stringWithFormat:@"   %@",[self getZhiDingDate:model.name]]];
            
            [itemArray addObject:item];
        }];
    } else if ([self.dateType isEqualToString:@"1"]) {
        //周
        [self.dataArr enumerateObjectsUsingBlock:^(StatisticAnalysisModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            XBarItem* item0 = [[XBarItem alloc] initWithDataNumber:[self goNumberWithStr:model.value]
                                                            color:waveColor
                                                     dataDescribe:[self fenGeStr:model.name]];

            [itemArray addObject:item0];
        }];
    } else if ([self.dateType isEqualToString:@"2"]) {
        //月
        [self.dataArr enumerateObjectsUsingBlock:^(StatisticAnalysisModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            XBarItem* item0 = [[XBarItem alloc] initWithDataNumber:[self goNumberWithStr:model.value]
                                                             color:waveColor
                                                      dataDescribe:model.name];
            
            [itemArray addObject:item0];
        }];
    }

    
    //获取数组中最大值
    NSMutableArray *maxArr = [NSMutableArray array];
    [itemArray enumerateObjectsUsingBlock:^(XBarItem *  _Nonnull tempObj, NSUInteger idx, BOOL * _Nonnull stop) {
        [maxArr addObject:tempObj.dataNumber];
    }];
    
    NSNumber *max=[maxArr valueForKeyPath:@"@max.doubleValue"];
    XBarChartConfiguration *configuration = [XBarChartConfiguration new];
    configuration.isScrollable = YES;
    configuration.x_width = 40;
    if (self.barChart) {
        [self.barChart removeFromSuperview];
    }
    self.barChart =
    [[XBarChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.profitCount.frame)+AD_HEIGHT(50), ScreenWidth, AD_HEIGHT(210))
                       dataItemArray:itemArray
                           topNumber:max
                        bottomNumber:@(0)
                  chartConfiguration:configuration];
    self.barChart.barChartDelegate = self;
    [self.view addSubview:self.barChart];
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
        
        //计算日期
        [self calauteTimeWithType:0];
        //时间类型
        self.dateType = @"0";
    } else if (btnTag == 1) {
        //周
        weekBtn.selected = YES;
        dayBtn.selected = !weekBtn.selected;
        monthBtn.selected = !weekBtn.selected;
        //计算日期
        [self calauteTimeWithType:1];
        //时间类型
        self.dateType = @"1";
    } else {
        //月
        monthBtn.selected = YES;
        weekBtn.selected = !monthBtn.selected;
        dayBtn.selected = !monthBtn.selected;
        //计算日期
        [self calauteTimeWithType:2];
        //时间类型
        self.dateType = @"2";
    }
    
    //更新接口数据
    [self getStatisticAnalysisData];
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
        
        //设置统计类型
        self.statType = @"0";
    } else if (btnTag == 1) {
        //分润
        [self changeBtn:separateQueryBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:bussinessCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:activeCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        //设置统计类型
        self.statType = @"1";
    } else if (btnTag == 2) {
        //商户数量
        [self changeBtn:bussinessCountBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:separateQueryBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:activeCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        //设置统计类型
        self.statType = @"4";
    }else {
        //激活数量
        [self changeBtn:activeCountBtn withSelectedStatus:YES withBgColor:C00A0E9];
        [self changeBtn:separateQueryBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:bussinessCountBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        [self changeBtn:profitBtn withSelectedStatus:NO withBgColor:CF6F6F6];
        //设置统计类型
        self.statType = @"2";
    }
    
    //更新接口数据
    [self getStatisticAnalysisData];
}

- (void)changeBtn:(UIButton *)sender withSelectedStatus:(BOOL)selectS withBgColor:(UIColor *)bgColor
{
    sender.selected = selectS;
    [sender setBackgroundColor:bgColor];
}



#pragma mark ---- 接口获取 ----
- (void)getStatisticAnalysisData
{
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/statAchievement/list" params:@{@"userid":IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:USERID]),@"startTime":IF_NULL_TO_STRING(self.startTime),@"endTime":IF_NULL_TO_STRING(self.endTime),@"statType":IF_NULL_TO_STRING(self.statType),@"dateType":IF_NULL_TO_STRING(self.dateType)} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"]isKindOfClass:[NSArray class]]) {
                    self.dataArr = [StatisticAnalysisModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                    [self creatChart];
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


#pragma mark ---- 生成指定格式日期 ----
- (NSString *)getZhiDingDate:(NSString *)dateStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    
    format.dateFormat = @"yyyy.MM.dd";
    
    // NSString * -> NSDate *
    
    NSDate *data = [format dateFromString:dateStr];
    
    NSString *newString = [format stringFromDate:data];
    return newString;
}

#pragma mark ---- 分割字符串 ----
- (NSString *)fenGeStr:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@"~"];
    NSString *tmpStr = [NSString stringWithFormat:@"%@ ~ %@",[array objectAtIndex:0],[array objectAtIndex:1]];
    return tmpStr;
}
@end
