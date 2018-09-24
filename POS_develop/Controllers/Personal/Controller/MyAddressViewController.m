//
//  MyAddressViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyAddressViewController.h"
#import "MyAddressTableViewCell.h"
#import "AddAddressViewController.h"

@interface MyAddressViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myAddressTableView;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"收货地址";
    self.view.backgroundColor = CF6F6F6;
    MJWeakSelf;
    UIButton *rightBtn = [self addRightBarButtonWithImage:[UIImage imageNamed:@"语音"] clickHandler:^{
        NSLog(@"点击右边按钮");
        AddAddressViewController *vc = [[AddAddressViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self createTableView];
}

- (void)createTableView {
    _myAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStyleGrouped];
    _myAddressTableView.backgroundColor = WhiteColor;
    _myAddressTableView.delegate = self;
    _myAddressTableView.dataSource = self;
    _myAddressTableView.showsVerticalScrollIndicator = NO;
    _myAddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myAddressTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyAddressTableViewCell *cell = [MyAddressTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = @"sunyn";
    cell.addressLabel.text = @"上海市 闵行区 世博家园二街坊 633弄 1~56号 52号楼2603室";
    cell.telephoneLabel.text = [@"17612197453" stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(109);
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return FITiPhone6(8);//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(5))];
    view.backgroundColor = CF6F6F6;
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = CF6F6F6;
    return view;
}
@end
