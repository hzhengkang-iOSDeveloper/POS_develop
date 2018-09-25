//
//  ActivationMoneyDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ActivationMoneyDetailViewController.h"
#import "ActivationMoneyDetailHeaderView.h"
@interface ActivationMoneyDetailViewController ()

@end

@implementation ActivationMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    ActivationMoneyDetailHeaderView *headerView = [[ActivationMoneyDetailHeaderView alloc] init];
    headerView.totalPenLabel.text = @"18000.01";
    headerView.totalAmountLabel.text = @"70";
    headerView.searchBlock = ^{
//        SeparateQuerySearchViewController *vc = [[SeparateQuerySearchViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(178 - navH)));
    }];
}

@end
