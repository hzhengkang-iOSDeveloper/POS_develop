//
//  MyBillViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MyBillViewController.h"
#import "MyBillTableViewCell.h"

@interface MyBillViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *billTableView;
@end

@implementation MyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"明细";
//    UIButton *rightBtn = [self addRightBarButtonWithImage:[UIImage imageNamed:@"图层1"] clickHandler:^{
//
//    }];
    UIButton *rightBtn = [self addRightBarButtonWithImage:[UIImage imageNamed:@"语音"] clickHandler:^{
        NSLog(@"点击右边按钮");
    }];
    [self createTableView];
}

- (void)createTableView {
    _billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _billTableView.backgroundColor = WhiteColor;
    _billTableView.delegate = self;
    _billTableView.dataSource = self;
    _billTableView.showsVerticalScrollIndicator = NO;
    _billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_billTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyBillTableViewCell *cell = [MyBillTableViewCell cellWithTableView:tableView];
    cell.contentLabel.text = @"提现";
    cell.timeLabel.text = @"2018.7.7 14:00";
    cell.amountLabel.text = @"+99";
    cell.totalAmountLabel.text = @"3000";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(65);
}
//#pragma  mark || SafeArea-适配iPhone X ||
//- (void)viewSafeAreaInsetsDidChange {
//    [super viewSafeAreaInsetsDidChange];
//
//    if (@available(iOS 11.0, *)) {
//        CGRect frame = self.billTableView.frame;
//        frame.origin.y = self.view.safeAreaInsets.top;
//        frame.origin.x = self.view.safeAreaInsets.left;
//        frame.size.width = self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right;
//        frame.size.height = self.view.frame.size.height - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top;
//        self.billTableView.frame = frame;
//    }
//}
@end
