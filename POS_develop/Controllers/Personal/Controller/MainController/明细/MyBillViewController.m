//
//  MyBillViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyBillViewController.h"
#import "MyBillTableViewCell.h"
#import "BagLogListModel.h"
#import "DatePickerView.h"

@interface MyBillViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *billTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *timeSelectView;
@property (nonatomic, strong) UIView *bgBlackView;
@property (nonatomic, strong) DatePickerView *datePickView;
@property (nonatomic, assign) int page;//接口数据当前页数
@end

@implementation MyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationItemTitle = @"明细";
    self.page = 0;
    self.dataArray = [NSMutableArray array];
        MJWeakSelf
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"图层1"] clickHandler:^{
        NSLog(@"点击右边按钮");
        weakSelf.bgBlackView.hidden = NO;
        weakSelf.timeSelectView.hidden = NO;
    }];
    [self createTableView];
    [self initUI];

    [self loadBagLogListRequest];
}
- (void)initUI {
    _bgBlackView = [UIView getViewWithColor:RGBA(0, 0, 0, 0.6) superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
        view.hidden = YES;
    }];
    _timeSelectView = [UIView getViewWithColor:WhiteColor superView:_bgBlackView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
        make.height.mas_equalTo(AD_HEIGHT(135));
        
        view.hidden = YES;
        view.layer.cornerRadius = AD_HEIGHT(5);
        view.layer.masksToBounds = YES;
    }];
    
    DatePickerView *datePickView = [[DatePickerView alloc] init];
    self.datePickView = datePickView;
   
    [_timeSelectView addSubview:datePickView];
    [datePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgBlackView.mas_left);
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    
    [UIButton getButtonWithImageName:@"" titleText:@"查询" superView:self.timeSelectView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(self.datePickView.mas_bottom).offset(AD_HEIGHT(20));
        make.centerX.offset(0);
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(130));
        make.height.mas_equalTo(AD_HEIGHT(40));
        
        btn.backgroundColor = C1E95F9;
        btn.titleLabel.font =F14;
        [btn addTarget:self action:@selector(selectTimeClick) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)selectTimeClick {
    self.bgBlackView.hidden = YES;
    self.timeSelectView.hidden = YES;
    [self loadBagLogListRequestWithStartTime:self.datePickView.datePickerStrA WithEndTime:self.datePickView.datePickerStrB];
}
- (void)createTableView {
    _billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _billTableView.backgroundColor = WhiteColor;
    _billTableView.delegate = self;
    _billTableView.dataSource = self;
    _billTableView.showsVerticalScrollIndicator = NO;
    _billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJWeakSelf;
    _billTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page =0;
        [weakSelf loadBagLogListRequest];
    }];
    
    _billTableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf loadBagLogListRequest];
    }];
    [self.view addSubview:_billTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyBillTableViewCell *cell = [MyBillTableViewCell cellWithTableView:tableView];
    BagLogListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(65);
}


#pragma mark -------------------------------- 接口 ------------------------------------

- (void)loadBagLogListRequest{
    NSDictionary *dict = @{@"offset":@(_page*10), @"limit":@10,@"userid":USER_ID_POS};

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagLog/list" params:dict cookie:nil result:^(bool success, id result) {
        [self.billTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        if (self.page == 0) {
                            [self.dataArray removeAllObjects];
                        }
                        NSArray *array = result[@"data"][@"rows"];
                        [self.dataArray addObjectsFromArray:[BagLogListModel mj_objectArrayWithKeyValuesArray:array]];
                        if (array.count < 10) {
                            [self.billTableView.mj_footer endRefreshingWithNoMoreData];
                        }
                        [self.billTableView reloadData];
                    }
                    
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
- (void)loadBagLogListRequestWithStartTime:(NSString *)startTime WithEndTime:(NSString *)endTime {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bagLog/list" params:@{@"userid":USER_ID_POS, @"startTime":startTime, @"endTime":endTime} cookie:nil result:^(bool success, id result) {
        [self.billTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"] integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = result[@"data"][@"rows"];
                        self.dataArray = [NSMutableArray arrayWithArray:[BagLogListModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.billTableView reloadData];
                    }
                    
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    self.bgBlackView.hidden = YES;
    self.timeSelectView.hidden = YES;
}
@end






















