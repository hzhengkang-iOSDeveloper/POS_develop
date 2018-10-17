//
//  MessageNoticeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageNoticeViewController.h"
#import "MessageNoticeTableViewCell.h"
#import "MessageListViewController.h"

@interface MessageNoticeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MessageNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"消息通知";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    
//    [self loadMessageCategoreRequest];
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
    MessageNoticeTableViewCell *cell = [MessageNoticeTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = CF6F6F6;
    cell.titleLabel.text = @"消息分类名称";
    cell.contentLabel.text = @"消息简介啥大事大是的ad发达阿达鹅鹅鹅饿";
    cell.timeLabel.text = @"2018.10.7";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListViewController *vc = [[MessageListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(60);
}



#pragma mark ---- 接口 ----
-(void)loadMessageCategoreRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"messageCategory/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    //            [self.dataArray addObjectsFromArray:[MessageListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTableView reloadData];
                }
                
            }
           
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
