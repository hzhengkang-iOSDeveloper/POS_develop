//
//  HtmlGenerailzeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeViewController.h"
#import "HtmlGenerailzeCell.h"
#import "HtmlGenerailzeDetailViewController.h"
#import "CopywritingSelectViewController.h"
@interface HtmlGenerailzeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *selectStr;
@end

@implementation HtmlGenerailzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"html5推广";
    [self addStandardRightButtonWithTitle:@"下一步" selector:@selector(nextClick)];
    self.selectStr = @"";
    [self createTableView];
}
#pragma mark ---- 下一步 ----
- (void)nextClick {
    CopywritingSelectViewController *vc = [[CopywritingSelectViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
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
    HtmlGenerailzeCell *cell = [HtmlGenerailzeCell cellWithTableView:tableView];
    cell.contentLabel.text = @"是安徽省等会看看安徽大家哈偶杜宇看看那，啊，了解了解欧式都普拉斯的聊扣扣OK哦偶uuuuka没空没空就看见alsjklajsdk框架爱健康hi是uayuya啊可能是大家见过人那可是  了撒娇了大家搜UI阿木木啦啦啦啦来了垃圾啊撒";
    
    cell.seeDetailBlock = ^{
        HtmlGenerailzeDetailViewController *vc = [[HtmlGenerailzeDetailViewController alloc] init];
        vc.contentStr = cell.contentLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        cell.selectBtn.selected = YES;
    } else {
        cell.selectBtn.selected = NO;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HtmlGenerailzeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected = !cell.selectBtn.selected;
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        self.selectStr = @"";
    } else {
        self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
    }
    
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(71);
}

@end
