//
//  PersonalViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeaderView.h"
#import "PersonalTableViewCell.h"
#import "LoginTypeViewController.h"
#import "VipSystemViewController.h"//会员系统
#import "PD_BillListViewController.h"//我的订单
#import "MyBillViewController.h"//账单
#import "MyFreeGetViewController.h"//免费领取
#import "MyAddressViewController.h"//我的地址
#import "SettingViewController.h"

#import "WithdrawCashViewController.h"
#import "SettingWithdrawPsViewController.h"
#import "MessageNoticeViewController.h"


@interface PersonalViewController () <UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic, strong) UITableView *personalTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) PersonalHeaderView *headerView;
@property (nonatomic, copy) NSString *balanceStr;
@property (nonatomic, copy) NSString *withDrawPasswd;
@property (nonatomic, copy) NSString *withDrawPasswdID;

@end

@implementation PersonalViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
//    [self loadBagListRequest];
//    [self loadStatAchievementRequest];
//    [self loadUserinfoRequest];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@{@"section":@[@"会员系统",@"我的订单",@"我的账单",@"免费领取",@"我的地址"]},@{@"section":@[@"我的客服",@"设置"]}];
    _imageArray = @[@{@"section":@[@"会员V1",@"我的订单",@"我的账单",@"免费领取",@"我的地址"]},@{@"section":@[@"我的客服",@"设置"]}];
    [self creatTabelView];
    [self loadBagListRequest];
    [self loadStatAchievementRequest];
    [self loadUserinfoRequest];
}

#pragma mark CreatTabelView
- (void)creatTabelView{
    _personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -STATUSBAR_H, ScreenWidth, ScreenHeight+STATUSBAR_H) style:UITableViewStyleGrouped];
    _personalTableView.backgroundColor = CF6F6F6;
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    _personalTableView.showsVerticalScrollIndicator = NO;
    _personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _personalTableView.tableHeaderView = [self creatTabHeaderView];
    MJWeakSelf;
    _personalTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadBagListRequest];
        [weakSelf loadStatAchievementRequest];
        [weakSelf loadUserinfoRequest];
    }];
    [self.view addSubview:_personalTableView];
}

#pragma mark -- 创建headerView
- (UIView *)creatTabHeaderView
{
    self.headerView = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(217) + STATUSBAR_H)];
    MJWeakSelf;
    self.headerView.loginBlock = ^{
        LoginTypeViewController *vc = [[LoginTypeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.headerView.messageBlock = ^{//消息
        MessageNoticeViewController *vc = [[MessageNoticeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    self.headerView.withdrawBlock = ^{
        if ([weakSelf.withDrawPasswd isEqualToString:@""] || weakSelf.withDrawPasswd == nil) {
            //没有设置提现密码，跳转设置提现密码界面
            SettingWithdrawPsViewController *vc = [[SettingWithdrawPsViewController alloc] init];
            vc.withDrawPasswdID = weakSelf.withDrawPasswdID;
            vc.popBlock = ^{
                [weakSelf loadBagListRequest];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else {
            WithdrawCashViewController *vc = [[WithdrawCashViewController alloc] init];
            vc.popBlock = ^{
                [weakSelf loadBagListRequest];
            };
            vc.balanceStr = [NSString stringWithFormat:@"%@", weakSelf.balanceStr];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];        }
        
    };
    
//    if ([[LoginManager getInstance] wasLogin]) {
    self.headerView.userNameLabel.hidden = NO;
    self.headerView.invitedCodeLabel.hidden = NO;
    self.headerView.userName.hidden = YES;
//    }else {
//        self.headerView.userNameLabel.hidden = YES;
//        self.headerView.invitedCodeLabel.hidden = YES;
//        self.headerView.userName.hidden = NO;
//    }


    
    return self.headerView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }else {
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalTableViewCell *cell = [PersonalTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text = [[_titleArray[indexPath.section] objectForKey:@"section"]objectAtIndex:indexPath.row];
    cell.imageView.image =[UIImage imageNamed: [[_imageArray[indexPath.section] objectForKey:@"section"]objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                VipSystemViewController *vc = [[VipSystemViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                PD_BillListViewController *vc = [[PD_BillListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{
                MyBillViewController *vc = [[MyBillViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:{
                MyFreeGetViewController *vc = [[MyFreeGetViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:{
                MyAddressViewController *vc = [[MyAddressViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 1:{
                SettingViewController *vc = [[SettingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(49);
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = CF6F6F6;
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FITiPhone6(5);
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(5))];
    view.backgroundColor = CF6F6F6;
    return view;
}



#pragma mark ---------------------------- 接口 --------------------------------

#pragma mark ---- 个人余额 ----
- (void)loadBagListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/bag/list" params:@{@"userid":USER_ID_POS }cookie:nil result:^(bool success, id result) {
        [self.personalTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [NSArray arrayWithArray:result[@"data"][@"rows"]];
                    if (array.count > 0) {
                        self.headerView.balanceL.text = [NSString stringWithFormat:@"余额：%@", IF_NULL_TO_STRING([[array firstObject] valueForKey:@"accountBalance"])];
                        self.balanceStr = IF_NULL_TO_STRING([[array firstObject] valueForKey:@"accountBalance"]);
                        self.withDrawPasswd = IF_NULL_TO_STRING([[array firstObject] valueForKey:@"withDrawPasswd"]);
                        self.withDrawPasswdID =  IF_NULL_TO_STRING([[array firstObject] valueForKey:@"id"]);
                        [self.personalTableView reloadData];
                    }
                    
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
#pragma mark ---- 昨日收益 ----
- (void)loadStatAchievementRequest {
    NSDate *date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天

    
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/statAchievement/list" params:@{@"userid":USER_ID_POS, @"startTime":[[NSString stringWithFormat:@"%@", lastDay] substringToIndex:10], @"endTime":[[NSString stringWithFormat:@"%@", lastDay] substringToIndex:10], @"dateType":@"0", @"statType":@"1"} cookie:nil result:^(bool success, id result) {
        [self.personalTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSArray class]]) {
                    
                    NSArray *array = [NSArray arrayWithArray:result[@"data"]];
                    if ([[array firstObject] valueForKey:@"value"]) {
                        self.headerView.yesterdayEarningsMoney.text = [[array firstObject] valueForKey:@"value"];
                    }else {
                        self.headerView.yesterdayEarningsMoney.text = @"0.00";
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
#pragma mark ---- 个人 用户信息 ----
- (void)loadUserinfoRequest {
    
    NSString *urlStr = [NSString stringWithFormat:@"?authCode=%@&authUserId=%@",IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:AUTHCODE]), IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:USERID])];
    
    [[HPDConnect connect] GetNetRequestMethod:[NSString stringWithFormat:@"sys/user/userinfo%@",urlStr] params:nil cookie:nil result:^(bool success, id result) {
        [self.personalTableView.mj_header endRefreshing];
        if (success) {
            
            self.headerView.userNameLabel.text = IF_NULL_TO_STRING([result[@"data"] valueForKey:@"nickname"]);
            self.headerView.invitedCodeLabel.text = [NSString stringWithFormat:@"推荐码：%@", IF_NULL_TO_STRING([result[@"data"] valueForKey:@"invitedCode"])];
            [self.headerView.iconImageV sd_setImageWithURL:URL(IF_NULL_TO_STRING([result[@"data"] valueForKey:@"picUrl"])) placeholderImage:ImageNamed(@"头像")];
        }
        
        
        NSLog(@"result ------- %@", result);
    }];
}

@end



















