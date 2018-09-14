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
#import "VipSystemViewController.h"
#import "MyBillViewController.h"
#import "MyAddressViewController.h"

@interface PersonalViewController () <UITableViewDelegate,UITableViewDataSource> {
    PersonalHeaderView *headerView;
}

@property (nonatomic, strong) UITableView *personalTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation PersonalViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
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
}

#pragma mark CreatTabelView
- (void)creatTabelView
{

    _personalTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _personalTableView.backgroundColor = CF6F6F6;
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    _personalTableView.showsVerticalScrollIndicator = NO;
    _personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _personalTableView.tableHeaderView = [self creatTabHeaderView];
    [self.view addSubview:_personalTableView];
}

#pragma mark -- 创建headerView
- (UIView *)creatTabHeaderView
{
    headerView = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(217))];
    MJWeakSelf;
    headerView.loginBlock = ^{
        LoginTypeViewController *vc = [[LoginTypeViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return headerView;
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
            case 2:{
                MyBillViewController *vc = [[MyBillViewController alloc] init];
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
@end



















