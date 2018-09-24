//
//  TransactionQueryViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionQueryViewController.h"
#import "DatePickerView.h"
@interface TransactionQueryViewController ()
@end

@implementation TransactionQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易查询";
    self.view.backgroundColor = CF6F6F6;
    
    [self initUI];
    
}
- (void)initUI {
    DatePickerView *datePickView = [[DatePickerView alloc] init];
    [self.view addSubview:datePickView];
    [datePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
