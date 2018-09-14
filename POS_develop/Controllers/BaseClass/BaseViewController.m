//
//  BaseViewController.m
//  ZNSuperWallet
//
//  Created by 孙亚男 on 2016/10/12.
//  Copyright © 2016年 孙亚男. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:(UIBarMetricsDefault)];

    
    
    self.view.backgroundColor = CF6F6F6;
}



@end
