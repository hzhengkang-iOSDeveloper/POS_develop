//
//  MessageListViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListTableViewCell.h"
#import "SelectDetailBrandViewController.h"

@interface MessageListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"消息列表";
    [self createTableView];
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = CF6F6F6;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListTableViewCell *cell = [MessageListTableViewCell cellWithTableView:tableView];
    cell.timeLabel.text = @"2018.10.7";
    cell.titleLabel.text = @"万福海鸿 - CEO来信";
    cell.contentLabel.text = @"我是CEO 我看看谁写代码写的这么好，优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀优秀";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SelectDetailBrandViewController *vc = [[SelectDetailBrandViewController alloc] init];
    vc.titleStr = cell.titleLabel.text;
    vc.contentStr = cell.contentLabel.text;
    vc.timeStr = cell.timeLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(88+32);
}

@end
