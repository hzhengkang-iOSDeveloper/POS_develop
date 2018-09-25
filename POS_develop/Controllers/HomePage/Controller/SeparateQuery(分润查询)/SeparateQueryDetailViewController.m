//
//  SeparateQueryDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQueryDetailViewController.h"
#import "SeparateQueryDetailHeaderView.h"
#import "SeparateQuerySearchViewController.h"

@interface SeparateQueryDetailViewController ()

@end

@implementation SeparateQueryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分润详情（个人）";
    [self initUI];
}

- (void)initUI {
    SeparateQueryDetailHeaderView *headerView = [[SeparateQueryDetailHeaderView alloc] init];
    headerView.totalLael.text = @"7000.00";
    headerView.totalPenLabel.text = @"18000";
    headerView.totalAmountLabel.text = @"7000188";
    headerView.searchBlock = ^{
        SeparateQuerySearchViewController *vc = [[SeparateQuerySearchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(178 - navH)));
    }];
}
@end
