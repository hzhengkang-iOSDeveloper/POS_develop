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
#import "MyAddressViewModel.h"
#import "MyAddressEditViewController.h"

@interface MyAddressViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myAddressTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"收货地址";
    self.view.backgroundColor = CF6F6F6;
    MJWeakSelf;
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"增加"] clickHandler:^{
        NSLog(@"点击右边按钮");
        AddAddressViewController *vc = [[AddAddressViewController alloc] init];
        vc.updateAddressList = ^{
            [weakSelf.myAddressTableView.mj_header beginRefreshing];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    _dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadAddressRequest ];
    
}

- (void)createTableView {
    _myAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStyleGrouped];
    _myAddressTableView.backgroundColor = WhiteColor;
    _myAddressTableView.delegate = self;
    _myAddressTableView.dataSource = self;
    _myAddressTableView.showsVerticalScrollIndicator = NO;
    _myAddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myAddressTableView];
    
    MJWeakSelf;
    _myAddressTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadAddressRequest];
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAddressViewModel *model = [_dataArray objectAtIndex:indexPath.section];
    MyAddressTableViewCell *cell = [MyAddressTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = model.receiverName;
    cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", model.province, model.city, model.county, model.receiverAddr];
    cell.telephoneLabel.text = model.receiverMp;
//    cell.telephoneLabel.text = [model.receiverMp stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    if ([model.defaultFlag isEqualToString:@"0"]) {
        cell.defaultAddressBtn.selected = YES;
    }else {
        cell.defaultAddressBtn.selected = NO;
    }
    cell.clickDefaultAddBlock = ^(UIButton *sender) {
        sender.selected = !sender.selected;
        [self loadUpdateAddressRequest:sender WithID:model.ID];
    };
    cell.clickDeleteAddBlock = ^{
        [self loadDeleteAddressRequest:model.ID withIndexP:indexPath];
    };
    cell.clickEditAddBlock = ^{
        MyAddressEditViewController *vc = [[MyAddressEditViewController alloc] init];
        vc.name = model.receiverName;
        vc.telephone = model.receiverMp;
        vc.detailAdd = model.receiverAddr;
        vc.province = model.province;
        vc.city = model.city;
        vc.county = model.city;
        vc.ID = model.ID;
        vc.defaultFlag = model.defaultFlag;
        vc.updateAddressList = ^{
            [self.myAddressTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
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

#pragma mark ---- 接口 ----
- (void)loadAddressRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/address/list" params:@{@"userid":@"1"} cookie:nil result:^(bool success, id result) {
        [self.myAddressTableView.mj_header endRefreshing];
        NSArray *array = result[@"data"][@"rows"];
        if (self.dataArray) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:[MyAddressViewModel mj_objectArrayWithKeyValuesArray:array]];
        [self.myAddressTableView reloadData];
        
        NSLog(@"result ------- %@", result);
    }];
}
- (void)loadUpdateAddressRequest:(UIButton *)sender WithID:(NSString *)ID {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/address/update" params:@{@"userid":@"1", @"defaultFlag":sender.selected?@0:@1, @"id":ID} cookie:nil result:^(bool success, id result) {
        [self.myAddressTableView reloadData];
        NSLog(@"result ------- %@", result);
    }];
}
#pragma mark ---- 删除 ----
- (void)loadDeleteAddressRequest:(NSString *)ID withIndexP:(NSIndexPath *)indexP {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"确认删除此地址么" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *comfir = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HPDConnect connect] PostNetRequestMethod:@"api/trans/address/remove" params:@{@"id":ID} cookie:nil result:^(bool success, id result) {
            if (success) {
                if ([result[@"msg"] isEqualToString:@"success"]) {
                    HUD_TIP(@"删除成功");
                    [self.dataArray removeObjectAtIndex:indexP.section];

                    [self.myAddressTableView beginUpdates];
                    [self.myAddressTableView deleteSections:[NSIndexSet indexSetWithIndex:indexP.section] withRowAnimation:UITableViewRowAnimationFade];
                    [self.myAddressTableView endUpdates];
                    
                    [self.myAddressTableView reloadData];
                }
            }
            NSLog(@"result ------- %@", result);
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:comfir];
    [controller addAction:cancel];
    [self.navigationController presentViewController:controller animated:YES completion:^{
        
    }];
    
}
@end
