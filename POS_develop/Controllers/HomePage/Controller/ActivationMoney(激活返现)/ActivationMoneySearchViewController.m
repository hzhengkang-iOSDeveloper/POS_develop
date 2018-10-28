//
//  ActivationMoneySearchViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ActivationMoneySearchViewController.h"
#import "ActivationMoneyCell.h"
#import "ActivationRebateListModel.h"

@interface ActivationMoneySearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    UIImageView *searchImgV;
    UITextField *searchTF;
}
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ActivationMoneySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self initUI];
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    
}
- (void)createTableView {
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITiPhone6(46), ScreenWidth, ScreenHeight - TabbarHeight - FITiPhone6(46)) style:UITableViewStylePlain];
    _searchTableView.backgroundColor = WhiteColor;
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.showsVerticalScrollIndicator = NO;
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_searchTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivationMoneyCell *cell = [ActivationMoneyCell cellWithTableView:tableView];
    cell.dateLabel.text = [NSString stringWithFormat:@"交易日期%@——%@", self.startTime, self.endTime];
    ActivationRebateListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(87);
}

- (void)initUI {
    UIImageView *searchImageV = [[UIImageView alloc] init];
    searchImageV.backgroundColor = RGB(238, 238, 238);
    searchImageV.layer.cornerRadius = FITiPhone6(16);
    searchImageV.layer.masksToBounds = YES;
    searchImageV.userInteractionEnabled = YES;
    searchImageV.image = [UIImage imageNamed:@"搜索框"];
    //    UITapGestureRecognizer *searchTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTap)];
    //    [searchImageV addGestureRecognizer:searchTap];
    [self.view addSubview:searchImageV];
    [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
    }];
    searchImgV = [[UIImageView alloc] init];
    searchImgV.userInteractionEnabled = YES;
    searchImgV.image = [UIImage imageNamed:@"搜索"];
    [searchImageV addSubview:searchImgV];
    [searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.centerY.equalTo(searchImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(16), FITiPhone6(16)));
    }];
    
    searchTF = [[UITextField alloc] init];
    searchTF.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    searchTF.delegate = self;
    [self.view addSubview:searchTF];
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
        
    }];
}


//搜索虚拟键盘响应

- (BOOL)textFieldShouldReturn:(UITextField *)textField



{
    
    NSLog(@"点击了搜索");
    
    [searchTF resignFirstResponder];
    
    [self loadActivationRebateListRequest];
    
    return YES;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    searchImgV.hidden = YES;
    return YES;
}
#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- 激活返现查询 ----
- (void)loadActivationRebateListRequest{
    
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/activationRebate/list" params:@{@"userid":@"1",@"startTime":defaultObject(self.startTime, @""), @"endTime":defaultObject(self.endTime, @""),@"agentName":defaultObject(searchTF.text, @""), @"agentType":self.agentType, @"orderBy":@""} cookie:nil result:^(bool success, id result) {
        [self.searchTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"objectList"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"objectList"];
                    if (self.dataArray.count >0) {
                        [self.dataArray removeAllObjects];
                    }
                    [self.dataArray addObjectsFromArray:[ActivationRebateListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.searchTableView reloadData];
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

@end
